import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  final firestore = FirebaseFirestore.instance;

  Future<void> write({
    required String collectionPath,
    required String documentPath,
    required Map<String, dynamic> data,
  }) async {
    await firestore.collection(collectionPath).doc(documentPath).set(data);
  }

  Future<void> delete({
    required String collectionPath,
    required String documentPath,
  }) async {
    await firestore.collection(collectionPath).doc(documentPath).delete();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> watchCollectionWithoutOrder(
      String collectionPath) {
    return FirebaseFirestore.instance.collection(collectionPath).snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> watchCollection(
      String collectionPath) {
    return FirebaseFirestore.instance
        .collection(collectionPath)
        .orderBy("dateTime", descending: true)
        .snapshots();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getInitial(String collectionPath,
      [int limit = 10]) async {
    return await FirebaseFirestore.instance
        .collection(collectionPath)
        .orderBy("dateTime", descending: true)
        .limit(limit)
        .get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getInitialWhere(
      String collectionPath, dynamic field, dynamic compareField,
      [int limit = 10]) async {
    return await FirebaseFirestore.instance
        .collection(collectionPath)
        .orderBy("dateTime", descending: true)
        .where(field, isEqualTo: compareField)
        .limit(limit)
        .get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getInitialWhereTwo(
      String collectionPath,
      dynamic field1,
      dynamic compareField1,
      dynamic field2,
      dynamic compareField2,
      dynamic orderBy,
      [int limit = 10]) async {
    return await FirebaseFirestore.instance
        .collection(collectionPath)
        .orderBy(orderBy)
        .where(field1, isEqualTo: compareField1)
        .where(field2, isGreaterThan: compareField2)
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
        .orderBy("dateTime", descending: true)
        .startAfter(startAfterId)
        .limit(limit)
        .get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchMoreWhereTwo(
      String collectionPath,
      List<String> startAfterId,
      dynamic field1,
      dynamic compareField1,
      dynamic field2,
      dynamic compareField2,
      [limit = 10]) async {
    return await FirebaseFirestore.instance
        .collection(collectionPath)
        .where(field1, isEqualTo: compareField1)
        .where(field2, isEqualTo: compareField2)
        .orderBy("dateTime", descending: true)
        .startAfter(startAfterId)
        .limit(limit)
        .get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchMore(
      String collectionPath, String startAfterId,
      [limit = 10]) async {
    return await FirebaseFirestore.instance
        .collection(collectionPath)
        .orderBy("dateTime", descending: true)
        .startAfter([startAfterId])
        .limit(limit)
        .get();
  }
}
