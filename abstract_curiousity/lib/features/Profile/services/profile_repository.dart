import 'package:abstract_curiousity/models/user.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileRepository {
  final _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  void updateNameAndBio({
    required String name,
    required String bio,
    required String email,
    required BuildContext context,
  }) async {
    try {
      DocumentReference userRef =
          _firestore.collection('users').doc(_firebaseAuth.currentUser!.uid);

      // Create a map with the fields to update
      Map<String, dynamic> data = {
        'name': name,
        'bio': bio,
      };
      await userRef.update(data);
      // http.Response res = await http.put(
      //   Uri.parse('$uri/api/editProfile'),
      //   body: jsonEncode({
      //     "name": name,
      //     "bio": bio,
      //     "email": email,
      //   }),
      //   headers: <String, String>{
      //     'Content-Type': 'application/json;charset=UTF-8',
      //   },
      // );
      // httpErrorHandle(
      //     response: res,
      //     context: context,
      //     onSuccess: () {
      //       showSnackBar(context, "Profile Details Updated");
      //     });
      // // print(res.body);
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to Update Data');
    }
  }

  Future<CustomUser?> getCurrentNameAndBio() async {
    CustomUser? customUser;
    try {
      // Get the current user's UID from Firebase Authentication
      String? uid = _firebaseAuth.currentUser?.uid;

      if (uid != null) {
        // Reference to the user's document in the 'users' collection
        DocumentSnapshot userSnapshot =
            await _firestore.collection('users').doc(uid).get();

        if (userSnapshot.exists) {
          // Convert the Firestore document data to a CustomUser object
          customUser =
              CustomUser.fromMap(userSnapshot.data() as Map<String, dynamic>);
        }
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to Retrieve Data');
    }

    return customUser;
  }

  // Future<CustomUser?> getCurrentNameAndBio({
  //   required String email,
  //   required BuildContext context,
  // }) async {
  //   CustomUser? customUser;
  //   try {
  //     http.Response res = await http.get(
  //       Uri.parse('$uri/api/getEditInfo?email=$email'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json;charset=UTF-8',
  //       },
  //     );
  //     // print("----------------------");
  //     // print(res.body);

  //     // ignore: use_build_context_synchronously
  //     if (res.statusCode == 200) {
  //       customUser = CustomUser.fromJson(res.body);
  //     }
  //     // httpErrorHandle(
  //     //   response: res,
  //     //   context: context,
  //     //   onSuccess: () {
  //     //     showSnackBar(context, "User Details Loaded");
  //     //   },
  //     // );
  //   } catch (e) {
  //     // print(e);
  //     throw Exception('Failed to Update Data');
  //   }

  //   return customUser;
  // }
}
