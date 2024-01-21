
import 'package:abstract_curiousity/features/HomePage/services/homerepository.dart';
import 'package:abstract_curiousity/globalvariables.dart';
import 'package:abstract_curiousity/models/article.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NavigationControls extends StatefulWidget {
  const NavigationControls(
      {required this.controller, super.key, required this.article});

  final WebViewController controller;
  final CustomArticle article;

  @override
  State<NavigationControls> createState() => _NavigationControlsState();
}

class _NavigationControlsState extends State<NavigationControls> {
  final HomeRepository homeRepository = HomeRepository();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width < 300 ? 180 : 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          LikeAsyncButton(article: widget.article),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: IconButton(
              icon: const Icon(Icons.replay),
              onPressed: () {
                widget.controller.reload();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class LikeAsyncButton extends StatelessWidget {
  final CustomArticle article;

  const LikeAsyncButton({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: checkIfArticleLiked(), // Replace with your user data stream
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Data is still loading
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // Error occurred
          return Text('Error: ${snapshot.error}');
        } else {
          final isLiked = snapshot.data;
          print("boolean value of article liked is     ${isLiked}");
          // print(articleData.toMap().toString());
          // Display UserLevelComponent with fetched data
          return isLiked == true
              ? IconButton(
                  onPressed: () {
                    printError("dislikedArticle");
                    HomeRepository().updateDislikeAnArticle(article);
                  },
                  icon: const Icon(
                    Icons.thumb_up_sharp,
                    color: Colors.white,
                  ))
              : IconButton(
                  onPressed: () {
                    print("Liked");
                    HomeRepository().updateLikeAnArticle(article);
                  },
                  icon: const Icon(
                    Icons.thumb_up_alt_outlined,
                    color: Colors.white,
                  ),
                );
        }
      },
    );
  }

  Stream<bool> checkIfArticleLiked() {
    final firestore = FirebaseFirestore.instance;
    final collection = firestore.collection("liked-articles");

    return collection
        .where("articleUrl", isEqualTo: article.url)
        .where("uId", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .snapshots()
        .map((doc) {
      // print(jsonEncode(doc.docs.first.data()));
      if (doc.docs.isNotEmpty) {
        print(doc.docs.first.data().toString());
        return true;
      } else {
        print("always returning false");
        return false;
      }
    });
  }
}
