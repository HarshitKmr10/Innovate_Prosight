// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LikedArticle {
  final String uId;
  final String articleUrl;
  // final String articleUid;

  LikedArticle({required this.uId, required this.articleUrl});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uId': uId,
      'articleUrl': articleUrl,
      // 'articleUid': articleUid,
    };
  }

  factory LikedArticle.fromMap(Map<String, dynamic> map) {
    return LikedArticle(
      uId: map['uId'] as String,
      articleUrl: map['articleUrl'] as String,
      // articleUid: map['articleUid'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LikedArticle.fromJson(String source) =>
      LikedArticle.fromMap(json.decode(source) as Map<String, dynamic>);
}
