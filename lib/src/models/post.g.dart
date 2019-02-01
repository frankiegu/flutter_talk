// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonModelGenerator
// **************************************************************************

@generatedSerializable
class PostInfo extends _PostInfo {
  PostInfo(
      {this.id,
      @required this.title,
      @required this.description,
      this.stub,
      List<String> categories,
      this.htmlContent,
      this.createdAt,
      this.updatedAt})
      : this.categories = new List.unmodifiable(categories ?? []);

  @override
  final String id;

  @override
  final String title;

  @override
  final String description;

  @override
  final String stub;

  @override
  final List<String> categories;

  @override
  final String htmlContent;

  @override
  final DateTime createdAt;

  @override
  final DateTime updatedAt;

  PostInfo copyWith(
      {String id,
      String title,
      String description,
      String stub,
      List<String> categories,
      String htmlContent,
      DateTime createdAt,
      DateTime updatedAt}) {
    return new PostInfo(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        stub: stub ?? this.stub,
        categories: categories ?? this.categories,
        htmlContent: htmlContent ?? this.htmlContent,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt);
  }

  bool operator ==(other) {
    return other is _PostInfo &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.stub == stub &&
        const ListEquality<String>(const DefaultEquality<String>())
            .equals(other.categories, categories) &&
        other.htmlContent == htmlContent &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return hashObjects([
      id,
      title,
      description,
      stub,
      categories,
      htmlContent,
      createdAt,
      updatedAt
    ]);
  }

  Map<String, dynamic> toJson() {
    return PostInfoSerializer.toMap(this);
  }
}

// **************************************************************************
// SerializerGenerator
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
        categories: map['categories'] is Iterable
            ? (map['categories'] as Iterable).cast<String>().toList()
            : null,
        htmlContent: map['html_content'] as String,
        createdAt: map['created_at'] != null
            ? (map['created_at'] is DateTime
                ? (map['created_at'] as DateTime)
                : DateTime.parse(map['created_at'].toString()))
            : null,
        updatedAt: map['updated_at'] != null
            ? (map['updated_at'] is DateTime
                ? (map['updated_at'] as DateTime)
                : DateTime.parse(map['updated_at'].toString()))
            : null);
  }

  static Map<String, dynamic> toMap(_PostInfo model) {
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
  static const List<String> allFields = <String>[
    id,
    title,
    description,
    stub,
    categories,
    htmlContent,
    createdAt,
    updatedAt
  ];

  static const String id = 'id';

  static const String title = 'title';

  static const String description = 'description';

  static const String stub = 'stub';

  static const String categories = 'categories';

  static const String htmlContent = 'html_content';

  static const String createdAt = 'created_at';

  static const String updatedAt = 'updated_at';
}
