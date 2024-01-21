import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:abstract_curiousity/globalvariables.dart';
import 'package:abstract_curiousity/models/article.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class HeadlineRepository {
  final firestore = FirebaseFirestore.instance;
  Future<List<CustomArticle>> fetchTopHeadlines() async {
    const String apiKey = API_KEY; // Replace with your actual API key
    const String apiUrl =
        'https://newsapi.org/v2/top-headlines?country=in&apiKey=$apiKey';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      // print(data);
      if (data['status'] == 'ok' && data['articles'] != null) {
        List<CustomArticle> articles = (data['articles'] as List)
            .map((articleData) => CustomArticle.fromMap(articleData))
            .toList();
        await saveArticlesToFirestore(articles);
        return articles;
      } else {
        throw Exception('Failed to fetch headlines');
      }
    } else {
      throw Exception('Failed to fetch headlines');
    }
  }

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
  }

  //increment read count

  Future<void> saveArticlesToFirestore(List<CustomArticle> articles) async {
    if (Firebase.apps.isEmpty) {
      await initializeFirebase();
    }
    // print(articles);
    final collection = firestore.collection("headlines");
    final querySnapshot = await firestore.collection("headlines").get();
    if (querySnapshot.docs.isNotEmpty) {
      final existingURLs = <String, bool>{};
      for (var doc in querySnapshot.docs) {
        final url = doc.data()["url"] as String;
        existingURLs[url] = true;
      }

      for (CustomArticle article in articles) {
        final articleURL = article.url;
        if (!existingURLs.containsKey(articleURL)) {
          if (article.title != "" && await classifyArticle(article.title)) {
            article.isFlagged = true;
            await collection.add(article.toMap());
            continue;
          }
          await collection.add(article.toMap());
        }
      }
    } else {
      for (CustomArticle article in articles) {
        // final articleURL = article.url;

        if (article.title != "" && await classifyArticle(article.title)) {
          article.isFlagged = true;
          await collection.add(article.toMap());
          continue;

          // await collection.add(article.toMap());
        }
        await collection.add(article.toMap());
      }
    }
  }
}

Future<bool> classifyArticle(String text) async {
  const String url = 'http://localhost:8000/classify';
  final response = await http.post(Uri.parse('$url?text=$text'));

  if (response.statusCode == 200) {
    return jsonDecode(response.body)[0]["label"] == "CLICKBAIT" ? true : false;
  } else {
    throw Exception('Failed to classify article');
  }
}
