import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  final firestore = FirebaseFirestore.instance;

  Future<QuerySnapshot<Map<String, dynamic>>> getInitial(String collectionPath,
      [int limit = 10]) async {
    return await FirebaseFirestore.instance
        .collection(collectionPath)
        .orderBy("dateTime")
        .limit(limit)
        .get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getInitialWhere(
      String collectionPath, dynamic field, dynamic compareField,
      [int limit = 10]) async {
    return await FirebaseFirestore.instance
        .collection(collectionPath)
        .orderBy("dateTime")
        .where(field, isEqualTo: compareField)
        .limit(limit)
        .get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchMoreWhere(
      String collectionPath,
      List<String> startAfterId,
      dynamic field,
      dynamic compareField,
      [limit = 10]) async {
    return await FirebaseFirestore.instance
        .collection(collectionPath)
        .where(field, isEqualTo: compareField)
        .orderBy("dateTime")
        .startAfter(startAfterId)
        .limit(limit)
        .get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchMore(
      String collectionPath, String startAfterId,
      [limit = 10]) async {
    return await FirebaseFirestore.instance
        .collection(collectionPath)
        .orderBy("dateTime")
        .startAfter([startAfterId])
        .limit(limit)
        .get();
  }
}
