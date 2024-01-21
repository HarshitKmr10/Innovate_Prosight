import 'package:abstract_curiousity/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserLevelComponent extends StatelessWidget {
  final String level;
  final int articlesRead;

  UserLevelComponent({
    required this.level,
    required this.articlesRead,
  });
Map<String, Map<String, int>> productMap = {
  '12ij292q9': {'quantity': 0, 'price': 123}
};


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.all(8),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(
            Icons.shield,
            color: Colors.orange,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            level,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          const Icon(
            Icons.lightbulb_outline,
            color: Colors.yellowAccent,
            size: 25,
          ),
          Text(
            ' $articlesRead reads',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}

class YourWidget extends StatelessWidget {
  final String userId;

  YourWidget({required this.userId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CustomUser?>(
      stream: getUserDataStream(), // Replace with your user data stream
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Data is still loading
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // Error occurred
          return Text('Error: ${snapshot.error}');
        } else {
          final userData = snapshot.data;

          if (userData == null) {
            // User not found
            return const Text('User not found');
          }
          // print(userData.toMap().toString());
          // Display UserLevelComponent with fetched data
          return UserLevelComponent(
            level: userData.numberOfArticles < 5
                ? 'Novice'
                : userData.numberOfArticles < 15
                    ? 'Seeker'
                    : "Expert",
            articlesRead: userData.numberOfArticles,
          );
        }
      },
    );
  }

  Stream<CustomUser?> getUserDataStream() {
    final firestore = FirebaseFirestore.instance;
    final usersCollection = firestore.collection("users");

    return usersCollection.doc(userId).snapshots().map((doc) {
      if (doc.exists) {
        return CustomUser.fromMap(doc.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    });
  }
}
