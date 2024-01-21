import 'package:abstract_curiousity/globalvariables.dart';

import 'package:abstract_curiousity/models/user.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return await _firebaseAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw Exception('The account already exists for that email.');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    throw Exception('Failed to sign in with Google');
  }

  void saveUsertoBackend({
    required BuildContext context,
    required User user,
    required Map<String, Set<String>> topics,
  }) async {
    try {
      //save user  to firebase backend in users collections
      final userDoc = await _firestore.collection('users').doc(user.uid).get();

      if (!userDoc.exists) {
        // User does not exist, save the new user data
        CustomUser customuser = CustomUser(
          name: user.displayName!,
          email: user.email!,
          topics: topics,
        );
        await _firestore
            .collection('users')
            .doc(user.uid)
            .set(customuser.toMap());
      }
      // CustomUser customuser = CustomUser(
      //   name: user.displayName!,
      //   email: user.email!,
      //   topics: topics,
      // );
      // _firestore.collection('users').doc(user.uid).set(customuser.toMap());

      // http.Response res = await http.post(
      //   Uri.parse('$uri/api/signup'),
      //   body: customuser.toJson(),
      //   headers: <String, String>{
      //     'Content-Type': 'application/json;charset=UTF-8',
      //   },
      // );
      // httpErrorHandle(
      //     response: res,
      //     context: context,
      //     onSuccess: () {
      //       showSnackBar(context, "Logged In");
      //     });
      // print(res.body);
    } catch (e) {
      printError(e.toString());
      throw Exception('Failed to Save Data');
    }
  }

  Future<void> signOut() async {
    try {
      GoogleSignIn().disconnect();
      await _firebaseAuth.signOut();
      printWarning('firebase post SIGNOUT user: ${_firebaseAuth.currentUser}');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'network-request-failed') {
        throw Exception('No internet connection');
      } else {
        throw Exception(e.toString());
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
