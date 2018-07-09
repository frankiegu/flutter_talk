import 'dart:async';
import 'dart:convert';
import 'package:angel_paginate/angel_paginate.dart';
import 'package:file/file.dart';
import 'package:flutter_talk/models.dart';
import 'package:logging/logging.dart';
import 'package:markdown/markdown.dart' as markdown;
import 'package:path/path.dart' as p;
import 'package:pooled_map/pooled_map.dart';
import 'models.dart';

const PostCacheBuilder postCacheBuilder = const PostCacheBuilder._();

class PostCacheBuilder {
  const PostCacheBuilder._();

  Future<PostCache> build(Logger logger, Directory directory) async {
    var pooledMap = new PooledMap<String, PostInfo>();
    var tasks = <Future>[];
    logger.config('Searching for posts in ${directory.absolute.path}...');

    await for (var entity in directory.list()) {
      if (entity is File) {
        tasks.add(entity.readAsString().then((contents) async {
          var post = PostInfoSerializer.fromMap(json.decode(contents));
          var markdownFile = directory.childFile(p.join(
              'markdown', p.setExtension(p.basename(entity.path), '.md')));

          if (!await markdownFile.exists()) {
            throw new StateError(
                'File for post does not exist: "${markdownFile.absolute
                    .path}"');
          } else {
            var jsonStat = await entity.stat();
            var markdownStat = await markdownFile.stat();
            var markdownContent = await markdownFile.readAsString();
            post = post.copyWith(
              stub: p.basenameWithoutExtension(entity.path),
              createdAt: jsonStat.changed,
              updatedAt: markdownStat.modified,
              categories: post.categories ?? [],
              htmlContent: markdown.markdownToHtml(
                markdownContent,
                extensionSet: markdown.ExtensionSet.gitHubWeb,
              ),
            );
            await pooledMap.putIfAbsent(post.stub, () => post);
          }
        }));
      }
    }

    await Future.wait(tasks);
    var map = await pooledMap.toMap();
    logger.config('Loaded cache: $map');
    return new PostCache(new Map<String, PostInfo>.unmodifiable(map));
  }
}

class PostCache {
  final PooledMap<String, Paginator<PostInfo>> paginators =
      new PooledMap<String, Paginator<PostInfo>>();
  final Map<String, PostInfo> posts;
  List<PostInfo> sortedByNewest;

  PostCache(this.posts) {
    sortedByNewest = posts.values.toList()
      ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
  }

  Future<PaginationResult<PostInfo>> findPaginated(
      String category, int page) async {
    PaginationResult<PostInfo> out;
    await paginators.update(
      category,
      (paginator) {
        paginator.goToPage(page);
        out = paginator.current;
        return paginator;
      },
      defaultValue: () {
        Iterable<PostInfo> posts;

        if (category == null) {
          posts = sortedByNewest;
        } else {
          posts = sortedByNewest
              .where((p) => p.categories.contains(category.toLowerCase()));
        }

        return new Paginator<PostInfo>(posts);
      },
    );
    return out;
  }
}
