import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';

import '../constant/collection_path.dart';
import '../model/auth_user.dart';
import '../constant/constant.dart';

class Api {
  final dio.Dio _dio = dio.Dio();

  //Send Notificaiton After order uploaded
  static Future<void> sendOrder(
    String title,
    String message,
  ) async {
    FirebaseFirestore.instance
        .collection(userCollection)
        .withConverter<AuthUser>(
          fromFirestore: (data, __) => AuthUser.fromJson(data.data()!),
          toFirestore: (user, __) => user.toJson(),
        )
        .where("status", isEqualTo: 1)
        .get()
        .then((value) async {
      final users = value.docs;
      for (var user in users) {
        final jsonBody = <String, dynamic>{
          "notification": <String, dynamic>{
            "title": title,
            "body": message,
          },
          "data": <String, dynamic>{
            "click_action": "FLUTTER_NOTIFICATION_CLICK",
            "route": "orderRoute",
          },
          "to": user.data().token,
        };
        await Dio().post("https://fcm.googleapis.com/fcm/send",
            data: jsonBody,
            options: Options(headers: {
              "Authorization": "key=$fcmKey",
              "Content-Type": "application/json"
            }));
      }
    });
  }

  static Future<void> notifyUserAboutHistOrder(
    String title,
    String message,
    String userId,
  ) async {
    FirebaseFirestore.instance
        .collection(userCollection)
        .withConverter<AuthUser>(
          fromFirestore: (data, __) => AuthUser.fromJson(data.data()!),
          toFirestore: (user, __) => user.toJson(),
        )
        .where("id", isEqualTo: userId)
        .get()
        .then((value) async {
      final user = value.docs.first;
      final jsonBody = <String, dynamic>{
        "notification": <String, dynamic>{
          "title": title,
          "body": message,
        },
        "data": <String, dynamic>{
          "click_action": "FLUTTER_NOTIFICATION_CLICK",
          "route": "orderRoute",
        },
        "to": user.data().token,
      };
      await Dio().post("https://fcm.googleapis.com/fcm/send",
          data: jsonBody,
          options: Options(headers: {
            "Authorization": "key=$fcmKey",
            "Content-Type": "application/json"
          }));
    });
  }
}
