// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// Generator: JsonModelGenerator
// **************************************************************************

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

  Map<String, dynamic> toJson() {
    return PostInfoSerializer.toMap(this);
  }
}
