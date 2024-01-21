import 'dart:convert';
import 'package:abstract_curiousity/Features/Headlines/services/headlinerepository.dart';
import 'package:abstract_curiousity/globalvariables.dart';
import 'package:abstract_curiousity/models/article.dart';
import 'package:abstract_curiousity/models/likedArticle.dart';
import 'package:abstract_curiousity/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;

class HomeRepository {
  final firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  static const String apiKey = API_KEY; // Replace with your News API key
  static const String baseUrl = 'https://newsapi.org/v2';

  Future<List<CustomArticle>> fetchNewsByTopic(String topic) async {
    final String uri =
        '$baseUrl/top-headlines?country=in&category=$topic&language=en&apiKey=$apiKey';

    final response = await http.get(Uri.parse(uri));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['status'] == 'ok' && data['articles'] != null) {
        List<CustomArticle> articles =
            (data['articles'] as List).map((articleData) {
          CustomArticle obj = CustomArticle.fromMap(articleData);
          saveArticleToFirestore(obj);
          return obj;
        }).toList();
        // await saveArticlesToFirestore(articles); // Save articles to Firestore
        return articles;
      } else {
        throw Exception('Failed to fetch headlines');
      }
    } else {
      throw Exception('Failed to fetch headlines');
    }
  }

  Future<void> updateLikeAnArticle(CustomArticle article) async {
    if (Firebase.apps.isEmpty) {
      await initializeFirebase();
    }

    final doc = await firestore
        .collection("articles")
        .where("url", isEqualTo: article.url)
        .get();

    for (var element in doc.docs) {
      element.reference.update({"likes": FieldValue.increment(1)});
      // print("likes : ${element.data()["likes"]}");
    }
    saveArticletoUserLiked(article);
  }

  Future<void> updateDislikeAnArticle(CustomArticle article) async {
    if (Firebase.apps.isEmpty) {
      await initializeFirebase();
    }

    final doc = await firestore
        .collection("articles")
        .where("url", isEqualTo: article.url)
        .get();

    for (var element in doc.docs) {
      element.reference.update({"likes": FieldValue.increment(-1)});
      print("likes : ${element.data()["likes"]}");
    }

    removeArticeOnDislike(article);
  }

  Future<void> saveArticletoUserLiked(CustomArticle article) async {
    if (Firebase.apps.isEmpty) {
      await initializeFirebase();
    }

    final collection = firestore.collection("liked-articles");

    final querySnapshot = await collection
        .where('articleUrl', isEqualTo: article.url)
        .where('uId', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .limit(1)
        .get();

    if (querySnapshot.docs.isEmpty) {
      final LikedArticle likedArticle =
          LikedArticle(articleUrl: article.url, uId: _auth.currentUser!.uid);
      await collection.add(likedArticle.toMap());
    }
  }

  Future<bool> checkifArticleLikedByUser(String articleUrl) async {
    if (Firebase.apps.isEmpty) {
      await initializeFirebase();
    }

    final collection = firestore.collection("liked-articles");

    final querySnapshot = await collection
        .where('url', isEqualTo: articleUrl)
        .where('uid', isEqualTo: _auth.currentUser?.uid)
        .limit(1)
        .get();

    if (querySnapshot.docs.isEmpty) {
      return false;
    }
    return true;
  }

  Future<void> removeArticeOnDislike(CustomArticle article) async {
    if (Firebase.apps.isEmpty) {
      await initializeFirebase();
    }

    final collection = firestore.collection("liked-articles");

    final querySnapshot = await collection
        .where('articleUrl', isEqualTo: article.url)
        .where('uId', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      await collection.doc(querySnapshot.docs.first.id).delete();
    }
  }

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
  }

  Future<void> saveArticleToFirestore(CustomArticle article) async {
    if (Firebase.apps.isEmpty) {
      await initializeFirebase();
    }

    final collection = firestore.collection("articles");

    final querySnapshot =
        await collection.where('url', isEqualTo: article.url).limit(1).get();

    if (querySnapshot.docs.isEmpty) {
      if (article.title != "" && await classifyArticle(article.title)) {
        article.isFlagged = true;
        await collection.add(article.toMap());
        return;
      }
      await collection.add(article.toMap());
    }
  }

  Future<void> saveArticlesToFirestore(List<CustomArticle> articles) async {
    if (Firebase.apps.isEmpty) {
      await initializeFirebase();
    }

    final collection = firestore.collection("articles");

    for (CustomArticle article in articles) {
      final querySnapshot =
          await collection.where('url', isEqualTo: article.url).limit(1).get();

      if (querySnapshot.docs.isEmpty) {
        if (article.title != "" && await classifyArticle(article.title)) {
          article.isFlagged = true;
          await collection.add(article.toMap());
          continue;
        }
        await collection.add(article.toMap());
      }
    }
  }

  Future<void> incrementReadCount(CustomArticle article) async {
    if (Firebase.apps.isEmpty) {
      await initializeFirebase();
    }

    final doc = await firestore
        .collection("headlines")
        .where("url", isEqualTo: article.url)
        .get();
    for (var element in doc.docs) {
      element.reference.update({"readCount": FieldValue.increment(1)});
    }
  }

  Future<String> fetchRandomQuote() async {
    final response =
        await http.get(Uri.parse('https://api.quotable.io/random'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data['content'] as String;
    } else {
      throw Exception('Failed to fetch a random quote');
    }
  }

  Future<CustomUser?> getUserData(String userId) async {
    try {
      final firestore = FirebaseFirestore.instance;
      final usersCollection = firestore.collection("users");

      final userDoc = await usersCollection.doc(userId).get();
      if (userDoc.exists) {
        final userData =
            CustomUser.fromMap(userDoc.data() as Map<String, dynamic>);
        return userData;
      } else {
        return null; // User not found
      }
    } catch (e) {
      // Handle any potential errors here
      return null;
    }
  }

  Future<void> saveArticleToUserHistory(CustomArticle article) async {
    if (Firebase.apps.isEmpty) {
      await initializeFirebase();
    }

    // Save the article in the history subcollection of each user
    final usersCollection = firestore.collection("users");
    final currentUserID = _auth.currentUser!.uid;

    final historyCollection =
        usersCollection.doc(currentUserID).collection("history");
    Map<String, dynamic> articleMap = article.toMap();
    articleMap['publishedAt'] = DateTime.now();

    await historyCollection.add(articleMap);
  }

  Future<void> incrementNumberOfArticlesRead() async {
    try {
      final firestore = FirebaseFirestore.instance;
      final usersCollection = firestore.collection("users");

      // Create a reference to the user's document in the users collection
      final userDocRef = usersCollection.doc(_auth.currentUser!.uid);

      // Increment the numberOfArticles field in the user's document by 1
      await userDocRef.update({'numberOfArticles': FieldValue.increment(1)});
    } catch (e) {
      throw Exception("Firebase Error Occured");
    }
  }

  Future<List<CustomArticle>> fetchUserHistory(String userId) async {
    try {
      final firestore = FirebaseFirestore.instance;
      final usersCollection = firestore.collection("users");

      final historyCollection =
          usersCollection.doc(userId).collection("history");

      final querySnapshot =
          await historyCollection.orderBy("publishedAt").get();

      if (querySnapshot.docs.isNotEmpty) {
        final articles = querySnapshot.docs.map((doc) {
          CustomArticle obj = CustomArticle.fromMap(doc.data());
          return obj;
        }).toList();
        return articles;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
    }
    return [];
  }

  Future<List<CustomArticle>> fetchNews() async {
    try {
      final firestore = FirebaseFirestore.instance;
      final articlesCollection = firestore.collection("articles");

      final querySnapshot = await articlesCollection
          .orderBy('publishedAt', descending: true)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        final articles = querySnapshot.docs
            .map((doc) => CustomArticle.fromMap(doc.data()))
            .toList();
        return articles;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
    }
    return [];
  }
}
