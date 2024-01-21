// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CustomUser {
  final String name;
  final String email;
  final bool writer;
  final String? bio;
  final dynamic topics;
  final int numberOfArticles;
  // final Map<String, List<String>>? topics;
  CustomUser({
    this.topics,
    required this.name,
    required this.email,
    this.writer = false,
    this.bio = "",
    this.numberOfArticles = 0,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'writer': writer,
      'bio': bio,
      'topics': topics,
      'numberOfArticles': numberOfArticles,
    };
  }

  factory CustomUser.fromMap(Map<String, dynamic> map) {
    return CustomUser(
      name: map['name'] as String,
      email: map['email'] as String,
      writer: map['writer'] as bool,
      bio: map['bio'] != null ? map['bio'] as String : null,
      topics: map['topics'],
      // != null
      //     ? Map<String, Set<String>>.from(map['topics'] as Map)
      //     : null,
      numberOfArticles: map['numberOfArticles'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomUser.fromJson(String source) =>
      CustomUser.fromMap(json.decode(source) as Map<String, dynamic>);
}
