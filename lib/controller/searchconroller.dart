// import 'package:get/get.dart';
//
// class SearchController extends GetxController {
//   var searchlist = [
//     {
//       "text": "Action Camera",
//     },
//     {
//       "text": "Cable",
//     },
//     {
//       "text": "Macbook",
//     },
//   ].obs;
//
//   var userDetails = [
//     {
//       "text": "Action Camera",
//     },
//     {
//       "text": "Cable",
//     },
//     {
//       "text": "Macbook",
//     },
//   ].obs;
//
//   onSearchTextChanged(String text) async {
//     searchlist.clear();
//     if (text.isEmpty) {
//       return;
//     }
//
//     userDetails.forEach((userDetail) {
//       if (userDetail['text'].toString().contains(text))
//         searchlist.add(userDetail);
//     });
//   }
// }
