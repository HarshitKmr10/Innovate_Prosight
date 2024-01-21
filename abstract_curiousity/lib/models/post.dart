import 'dart:convert';

import 'package:abstract_curiousity/models/user.dart';

class Post {
  final CustomUser author; // You can use the User model here.
  final String title;
  final String description;
  final String url;
  final String? urlToImage;
  final DateTime publishedAt;
  final String? content;
  final String? summary;

  Post({
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    this.urlToImage = "",
    required this.publishedAt,
    this.content = "",
    this.summary = "",
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'author': author.toMap(),
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt.millisecondsSinceEpoch,
      'content': content,
      'summary': summary,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      author: CustomUser.fromMap(map['author'] as Map<String, dynamic>),
      title: map['title'] as String,
      description: map['description'] as String,
      url: map['url'] as String,
      urlToImage:
          map['urlToImage'] != null ? map['urlToImage'] as String : null,
      publishedAt:
          DateTime.fromMillisecondsSinceEpoch(map['publishedAt'] as int),
      content: map['content'] != null ? map['content'] as String : null,
      summary: map['summary'] != null ? map['summary'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) =>
      Post.fromMap(json.decode(source) as Map<String, dynamic>);
}
