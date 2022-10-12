import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:citymall/admin/advertisement/controller/ad_controller.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';

import '../../../colors/colors.dart';
import '../../../controller/db_data_controller.dart';
import '../../../widgets/form/image_pick_form.dart';

class AdView extends StatelessWidget {
  const AdView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ADController adController = Get.find();
    final DBDataController dataController = Get.find();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        title: const Center(
            child: Text("ကြော်ငြာ အုပ်စုများ",
                style: TextStyle(
                  color: Colors.black,
                ))),
        actions: [
          Padding(
              padding: const EdgeInsets.only(
                top: 5,
                bottom: 5,
                right: 10,
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: ColorResources.blue1,
                ),
                onPressed: () => adController.save(),
                child: const Text("Save"),
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          bottom: 16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(() {
              final pickedImage = adController.pickedImage.value;
              final isEmpty = pickedImage.isEmpty;
              return ImagePickForm(
                labelText: isEmpty ? "pick an image" : pickedImage,
                pickImage: () => adController.pickImage(),
              );
            }),
            //ImagePickFormError
            Obx(() {
              return adController.isFirstTimePressed.value &&
                      adController.pickedImage.isEmpty
                  ? const Text("Image is required.",
                      style: TextStyle(
                        color: Colors.red,
                      ))
                  : const SizedBox();
            }),
            const SizedBox(height: 15),
            /**Advertisement List*/
            Expanded(
              child: Obx(
                () {
                  if (dataController.advertisements.isEmpty) {
                    return const Center(
                        child: Text(
                      "No advertisement yet....",
                    ));
                  }

                  return ListView.builder(
                    itemCount: dataController.advertisements.length,
                    itemBuilder: (context, index) {
                      var advertisement = dataController.advertisements[index];

                      return SwipeActionCell(
                        key: ValueKey(advertisement.id),
                        trailingActions: [
                          SwipeAction(
                            onTap: (CompletionHandler _) async {
                              await _(true);
                              await adController.delete(advertisement.id);
                            },
                            content: Container(
                              color: Colors.red,
                              height: 35,
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "DELETE",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            color: Colors.white,
                          ),
                        ],
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                            minHeight: 50,
                            maxHeight: 100,
                          ),
                          child: Card(
                            child: CachedNetworkImage(
                              progressIndicatorBuilder: (context, url, status) {
                                return Shimmer.fromColors(
                                  baseColor: Colors.grey,
                                  highlightColor: Colors.white,
                                  child: Container(
                                    color: Colors.white,
                                  ),
                                );
                              },
                              errorWidget: (context, url, whatever) {
                                return const Text("Image not available");
                              },
                              imageUrl: advertisement.image,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
