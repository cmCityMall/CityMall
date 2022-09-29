import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../constant/collection_path.dart';
import '../rout_screens/rout_1.dart';
import '../show_loading/show_loading.dart';
import 'database.dart';

class Auth {
  Future<void> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      showLoading();
      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      await FirebaseAuth.instance.signInWithCredential(credential);
      hideLoading();
      Get.off(NavigationBarBottom());
    } on FirebaseAuthException catch (e) {
      debugPrint("GoogleSignInError: $e");
      Get.snackbar("Fail!", "$e");
    }
  }

  Future<void> logOut() async {
    showLoading();
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      debugPrint("*******LOGOUT Exception: $e");
    }
    hideLoading();
  }

  Future<void> deleteAccount(String userId) async {
    final database = Database();
    showLoading();
    await database
        .delete(
      collectionPath: userCollection,
      documentPath: userId,
    )
        .then((value) async {
      try {
        await FirebaseAuth.instance.currentUser?.delete();
      } on FirebaseAuthException catch (e) {
        if (e.code == "requires-recent-login") {
          //TODO: WE NEED TO PROMPT TO REAUTHENTICATE,then delete() again
          debugPrint("**********${e.code}");
          return;
        }
        debugPrint("**********${e.code}");
      }
    });
    hideLoading();
  }
}
