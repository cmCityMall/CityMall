import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:citymall/constant/collection_path.dart';
import 'package:citymall/constant/mock.dart';
import 'package:citymall/model/auth_user.dart';

import '../server/auth.dart';
import '../server/database.dart';

class AuthController extends GetxController {
  final _auth = FirebaseAuth.instance;
  final _authObject = Auth();
  final _database = Database();
  StreamSubscription? userStreamSubscription;
  int currentUserPoint = 0;
  var currentUserDeviceToken = "".obs;
  Rxn<AuthUser> currentUser = Rxn<AuthUser>(AuthUser.guest());

  @override
  void onInit() {
    getDeviceToken();
    FirebaseMessaging.instance.onTokenRefresh.listen(saveTokenToDatabase);
    listenCurrentUser();
    super.onInit();
  }

  Future<void> googleSingIn() async {
    await _authObject.signInWithGoogle();
  }

  Future<void> logOut() async {
    _authObject.logOut().then((value) {
      currentUser.value = AuthUser.guest();
      currentUserPoint = 0;
    });
  }

  Future<void> delete() async {
    _authObject.deleteAccount(currentUser.value!.id).then((value) {
      currentUser.value = AuthUser.guest();
      currentUserPoint = 0;
    });
  }

  void listenCurrentUser() {
    _auth.authStateChanges().listen((user) async {
      debugPrint("*******CurrentUser is: ${user?.displayName}");
      if (user == null || user.photoURL == null) {
        //Nothing do if user is null & annonymous user
      } else {
        debugPrint("*******user is not null****");
        //we need to check document reference is already defined
        final snapshot = await FirebaseFirestore.instance
            .collection(userCollection)
            .doc(user.uid)
            .get();
        if (!snapshot.exists) {
          //If not define before
          debugPrint("******Document is not exist so,we write to firebase");
          currentUser.value = AuthUser(
            id: user.uid,
            emailAddress: user.email!,
            userName: user.displayName!,
            image: user.photoURL!,
            points: 0,
            status: 1,
            token: currentUserDeviceToken.value,
          );
          await _database.write(
            collectionPath: userCollection,
            documentPath: currentUser.value!.id,
            data: currentUser.value!.toJson(),
          );
        } else {
          currentUser.value = AuthUser.fromJson(snapshot.data()!);
          currentUserPoint = currentUser.value!.points;
        }
        if (!(userStreamSubscription == null)) {
          //if already subscripe before,need to cancel
          //to subscripe new
          userStreamSubscription?.cancel();
        }
        //If user is not null,we watch this current user's document
        userStreamSubscription = FirebaseFirestore.instance
            .collection(userCollection)
            .doc(user.uid)
            .snapshots()
            .listen((event) {
          if (event.exists) {
            debugPrint("****UserEvent: ${event.data()}");
            currentUser.value = AuthUser.fromJson(event.data()!);
            currentUserPoint = currentUser.value!.points;
          }
        });
      }
    });
  }

  //-------------------------GET TOKEN--------------------//
  Future<void> getDeviceToken() async {
    try {
      currentUserDeviceToken.value =
          await FirebaseMessaging.instance.getToken() ?? "";
    } catch (e) {
      debugPrint("**************Error Getting Token: $e");
    }
  }

  Future<void> saveTokenToDatabase(String token) async {
    FirebaseFirestore.instance.runTransaction((transaction) async {
      try {
        final secureSnapshot = await FirebaseFirestore.instance
            .collection(userCollection)
            .doc(currentUser.value!.id)
            .get();
        transaction.update(secureSnapshot.reference, {
          "token": currentUserDeviceToken.value,
        });
      } catch (e) {
        Get.snackbar("Fail!", "$e");
      }
    });
  }
}
