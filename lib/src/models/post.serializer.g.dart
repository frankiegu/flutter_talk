// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// Generator: SerializerGenerator
// **************************************************************************

abstract class PostInfoSerializer {
  static PostInfo fromMap(Map map) {
    if (map['title'] == null) {
      throw new FormatException("Missing required field 'title' on PostInfo.");
    }

    if (map['description'] == null) {
      throw new FormatException(
          "Missing required field 'description' on PostInfo.");
    }

    return new PostInfo(
        id: map['id'] as String,
        title: map['title'] as String,
        description: map['description'] as String,
        stub: map['stub'] as String,
        categories: map['categories'] as List<String>,
        htmlContent: map['html_content'] as String,
        createdAt: map['created_at'] != null
            ? (map['created_at'] is DateTime
                ? (map['created_at'] as DateTime)
                : DateTime.parse(map['created_at']))
            : null,
        updatedAt: map['updated_at'] != null
            ? (map['updated_at'] is DateTime
                ? (map['updated_at'] as DateTime)
                : DateTime.parse(map['updated_at']))
            : null);
  }

  static Map<String, dynamic> toMap(PostInfo model) {
    if (model == null) {
      return null;
    }
    if (model.title == null) {
      throw new FormatException("Missing required field 'title' on PostInfo.");
    }

    if (model.description == null) {
      throw new FormatException(
          "Missing required field 'description' on PostInfo.");
    }

    return {
      'id': model.id,
      'title': model.title,
      'description': model.description,
      'stub': model.stub,
      'categories': model.categories,
      'html_content': model.htmlContent,
      'created_at': model.createdAt?.toIso8601String(),
      'updated_at': model.updatedAt?.toIso8601String()
    };
  }
}

abstract class PostInfoFields {
  static const String id = 'id';

  static const String title = 'title';

  static const String description = 'description';

  static const String stub = 'stub';

  static const String categories = 'categories';

  static const String htmlContent = 'html_content';

  static const String createdAt = 'created_at';

  static const String updatedAt = 'updated_at';
}
