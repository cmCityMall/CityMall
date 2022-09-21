import 'package:citymall/constant/collection_path.dart';
import 'package:citymall/constant/mock.dart';
import 'package:citymall/model/main_category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class DBDataController extends GetxController {
  Future<void> writeMainCategory() async {
    for (var i = 0; i < 50; i++) {
      final id = Uuid().v1();
      await FirebaseFirestore.instance
          .collection(mainCategoryCollection)
          .doc(id)
          .set(MainCategory(
            id: id,
            name: "Main Category $i",
            image: mockMainCategory,
            isMenu: i > 25 ? true : false,
            dateTime: DateTime.now(),
          ).toJson());
    }
  }
}
