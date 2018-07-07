library angel.src.routes;

import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:angel_cors/angel_cors.dart';
import 'package:angel_framework/angel_framework.dart';
import 'package:angel_paginate/angel_paginate.dart';
import 'package:angel_static/angel_static.dart';
import 'package:code_buffer/code_buffer.dart';
import 'package:file/file.dart';
import 'package:flutter_talk/models.dart';
import 'package:flutter_talk/post_cache.dart';
import 'controllers/controllers.dart' as controllers;

AngelConfigurer configureServer(FileSystem fileSystem) {
  return (Angel app) async {
    app.use(cors());
    await app.configure(controllers.configureServer);

    app.get('/',
        (RequestContext req, ResponseContext res) => res.render('landing'));

    app.get('/posts', (PostCache postCache, DateTime startTime,
        RequestContext req, ResponseContext res) async {
      // Paginators cache pages, so let's take advantage of this to only do
      // lookups once.
      var pagination = await postCache.findPaginated(
          req.query['category']?.toString(),
          int.tryParse(req.query['page'].toString()) ?? 1);

      // Check for 304
      if (req.headers.ifModifiedSince != null &&
          !startTime.isAfter(req.headers.ifModifiedSince)) {
        if (!pagination.data
            .any((p) => p.updatedAt.isAfter(req.headers.ifModifiedSince))) {
          res.statusCode = 304;
          return false;
        }
      }

      res.headers['last-modified'] = HttpDate.format(new DateTime.now());
      await res.render('posts', {
        'pagination': pagination,
        'category': req.query['category'],
        'hasNextPage': pagination.nextPage > -1,
        'title': 'Newest'
      });
    });

    app.get('/posts/:stub', (String stub, DateTime startTime,
        PostCache postCache, RequestContext req, ResponseContext res) async {
      var post = postCache.posts[stub];

      if (post == null) {
        throw new AngelHttpException.notFound();
      } else if (req.headers.ifModifiedSince != null &&
          !startTime.isAfter(req.headers.ifModifiedSince) &&
          !post.updatedAt.isAfter(req.headers.ifModifiedSince)) {
        res.statusCode = 304;
        return false;
      } else {
        res.headers['last-modified'] = HttpDate.format(new DateTime.now());
        await res.render('post', {
          'post': post,
          'title': post.title,
        });
      }
    });

    app.get('/categories', (PostCache postCache, DateTime startTime,
        RequestContext req, ResponseContext res) async {
      // Paginators cache pages, so let's take advantage of this to only do
      // lookups once.

      // Check for 304
      if (req.headers.ifModifiedSince != null &&
          !startTime.isAfter(req.headers.ifModifiedSince)) {
        if (!postCache.sortedByNewest
            .any((p) => p.updatedAt.isAfter(req.headers.ifModifiedSince))) {
          res.statusCode = 304;
          return false;
        }
      }

      var categories = new SplayTreeSet<String>();

      for (var p in postCache.sortedByNewest) {
        categories.addAll(p.categories);
      }

      res.headers['last-modified'] = HttpDate.format(new DateTime.now());
      await res.render('categories', {
        'categories': categories.toList(),
        'title': 'Categories',
      });
    });

    app.get('/feed.xml', (PostCache postCache, DateTime startTime,
        RequestContext req, ResponseContext res) async {
      // Paginators cache pages, so let's take advantage of this to only do
      // lookups once.

      // Check for 304
      if (req.headers.ifModifiedSince != null &&
          !startTime.isAfter(req.headers.ifModifiedSince)) {
        if (!postCache.sortedByNewest
            .any((p) => p.updatedAt.isAfter(req.headers.ifModifiedSince))) {
          res.statusCode = 304;
          return false;
        }
      }

      var b = new CodeBuffer();
      b
        ..writeln('<?xml version="1.0" encoding="utf-8"?>')
        ..writeln('<rss version="2.0">')
        ..indent()
        ..writeln('<channel>')
        ..indent()
        ..writeln('<title>Flutter Talk</title>')
        ..writeln('<link>https://flutter.thosakwe.com</link>')
        ..writeln('<description>${htmlEscape.convert(
              'Learn <a href="https://flutter.io" target="_blank" style="font-weight: bold">Flutter</a> today, with tutorials, videos, and interactive exercises for the hottest mobile framework.')}</description>')
        ..writeln('<language>en-us</language>')
        ..writeln('<pubDate>${HttpDate.format(new DateTime.now())}</pubDate>')
        ..writeln('<lastBuildDate>${HttpDate.format(
              new DateTime.now())}</lastBuildDate>')
        ..writeln('<docs>http://blogs.law.harvard.edu/tech/rss</docs>')
        ..writeln('<generator>Angel Framework</generator>');

      for (var p in postCache.sortedByNewest) {
        /* <item>
<title>Star City</title>
<link>
http://liftoff.msfc.nasa.gov/news/2003/news-starcity.asp
</link>
<description>
How do Americans get ready to work with Russians aboard the International Space Station? They take a crash course in culture, language and protocol at Russia's <a href="http://howe.iki.rssi.ru/GCTC/gctc_e.htm">Star City</a>.
</description>
<pubDate>Tue, 03 Jun 2003 09:39:21 GMT</pubDate>
<guid>
http://liftoff.msfc.nasa.gov/2003/06/03.html#item573
</guid>
</item>
*/
        b
          ..writeln('<item>')
          ..indent()
          ..writeln('<title>${p.title}</title>')
          ..writeln('<description>${p.description}</description>')
          ..writeln('<link>https://flutter.thosakwe.com/posts/${p
                .stub}</link>')
          ..writeln('<pubDate>${HttpDate.format(p.createdAt)}</pubDate>')
          ..writeln('<guid>https://flutter.thosakwe.com/posts/${p.stub}</guid>')
          ..outdent()
          ..writeln('</item>');
      }

      b
        ..outdent()
        ..writeln('</channel>')
        ..outdent()
        ..writeln('</rss>');

      res.headers['content-type'] = 'text/xml';
      res.write(b.toString());
      return false;
    });

    var vDir = new VirtualDirectory(
      app,
      fileSystem,
      source: fileSystem.directory('web'),
    );
    app.use(vDir.handleRequest);

    // Throw a 404 if no route matched the request.
    app.use(() => throw new AngelHttpException.notFound());
  };
}
