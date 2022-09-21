// import 'package:get/get.dart';
//
// class WeekPromotionSearchController extends GetxController {
//   var searchlist = [
//     {
//       "text": "Action Camera\nHDR",
//     },
//     {
//       "text": "Compact Camera\nHigh...",
//     },
//     {
//       "text": "Action Camera\nHDR",
//     },
//     {
//       "text": "Compact Camera\nHigh...",
//     },
//   ].obs;
//
//   var userDetails = [
//     {
//       "text": "Action Camera\nHDR",
//     },
//     {
//       "text": "Compact Camera\nHigh...",
//     },
//     {
//       "text": "Action Camera\nHDR",
//     },
//     {
//       "text": "Compact Camera\nHigh...",
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
