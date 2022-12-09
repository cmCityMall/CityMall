import 'package:cached_network_image/cached_network_image.dart';
import 'package:citymall/admin/product/view/upload_product.dart';
import 'package:citymall/admin/reward_product/view/upload_reward_product.dart';
import 'package:citymall/controller/db_data_controller.dart';
import 'package:citymall/utils/widgets/empty_widgt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../colors/colors.dart';
import '../../../images/images.dart';
import '../controller/reward_product_controller.dart';

class ManageRewardProduct extends StatelessWidget {
  const ManageRewardProduct({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final RewardProductController rewardProductController = Get.find();
    final DBDataController dataController = Get.find();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: const Text(
          "REWARD PRODUCTS",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            // fontStyle: FontStyle.italic,
            wordSpacing: 2,
            letterSpacing: 3,
          ),
        ),
        elevation: 0,
        leading: IconButton(
          onPressed: Get.back,
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              top: 8,
              right: 20,
              bottom: 8,
            ),
            child: InkWell(
              onTap: () => rewardProductController.scanBarCodeForSearch(),
              child: Image.asset(
                Images.barCode,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorResources.blue1,
        child: const Icon(
          FontAwesomeIcons.plus,
          color: Colors.white,
        ),
        onPressed: () {
          dataController.setEditRewardProduct(null);
          Get.to(() => const UploadRewardProduct());
          rewardProductController.configureForEditRewardProduct();
        },
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: rewardProductController.editingController,
              onChanged: (value) => rewardProductController.onSearch(value),
              // onSubmitted: homeController.searchItem,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: "Search",
                  suffixIcon: IconButton(
                    onPressed: () => rewardProductController.clearSearch(),
                    icon: const Icon(Icons.clear),
                  )),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (rewardProductController.isSearch.value &&
                  rewardProductController.searchItems.isEmpty) {
                return const EmptyWidget("No products found.");
              }
              return ListView.builder(
                  itemCount: rewardProductController.isSearch.value
                      ? rewardProductController.searchItems.length
                      : rewardProductController.products.length,
                  itemBuilder: (_, i) {
                    final item = rewardProductController.isSearch.value
                        ? rewardProductController.searchItems[i]
                        : rewardProductController.products[i];
                    return SwipeActionCell(
                      key: ValueKey(item.id),
                      trailingActions: [
                        SwipeAction(
                          onTap: (CompletionHandler _) async {
                            await _(true);
                            await rewardProductController.delete(item.id);
                          },
                          title: 'Delete',
                        ),
                        SwipeAction(
                          color: Colors.grey,
                          onTap: (CompletionHandler _) async {
                            await _(false);
                            dataController.setEditRewardProduct(item);
                            rewardProductController
                                .configureForEditRewardProduct();
                            Get.to(() => const UploadRewardProduct());
                          },
                          title: 'Edit',
                        ),
                      ],
                      child: Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        height: 140,
                        child: Card(
                          elevation: 5,
                          child: Row(
                            children: [
                              CachedNetworkImage(
                                imageUrl: item.image,
                                width: 100,
                                height: 125,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.name,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    /* Text(
                                      item.features ?? "",
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        wordSpacing: 1,
                                      ),
                                    ), */
                                    Text(
                                      "${item.requiredPoint} points",
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }),
          )
        ],
      ),
    );
  }
}
