import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class WebViewRepository {
  // final _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<String>> extractContentFromFirestore(String url) async {
    try {
      final articlesCollection = _firestore.collection("articles");

      final querySnapshot =
          await articlesCollection.where("url", isEqualTo: url).get();
      if (querySnapshot.docs.isNotEmpty) {
        final articleData =
            querySnapshot.docs.first.data() as Map<String, dynamic>;
        final String content = articleData["content"] ?? "No content available";
        final String summary = articleData["summary"] ?? "";
        // setState(() {
        //   _extractedContent = content;
        //   _summary = summary;
        // });
        return [content, summary];
      }
    } catch (e) {
      print(e);
    }
    return [];
  }

  Future<void> saveSummaryToFirebase(String summary, String url) async {
    final String articleURL = url;

    final QuerySnapshot snapshot = await _firestore
        .collection('articles')
        .where('url', isEqualTo: articleURL)
        .get();

    if (snapshot.docs.isNotEmpty) {
      final DocumentSnapshot articleDoc = snapshot.docs.first;
      await articleDoc.reference.update({
        'summary': summary,
      });
    }
  }
}
