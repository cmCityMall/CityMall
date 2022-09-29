import 'package:cached_network_image/cached_network_image.dart';
import 'package:citymall/admin/product/view/upload_product.dart';
import 'package:citymall/controller/db_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../controller/product_controller.dart';

class ManageProduct extends StatelessWidget {
  const ManageProduct({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.find();
    final DBDataController dataController = Get.find();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: const Text(
          "PRODUCTS",
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
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          FontAwesomeIcons.plus,
          color: Colors.white,
        ),
        onPressed: () {
          dataController.setEditProduct(null);
          Get.to(() => const UploadProduct());
        },
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: productController.editingController,
              onChanged: (value) => productController.onSearch(value),
              // onSubmitted: homeController.searchItem,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: "Search",
                  suffixIcon: IconButton(
                    onPressed: () => productController.clearSearch(),
                    icon: const Icon(Icons.clear),
                  )),
            ),
          ),
          Expanded(
            child: Obx(
              () => ListView.builder(
                  itemCount: productController.isSearch.value
                      ? productController.searchItems.length
                      : productController.products.length,
                  itemBuilder: (_, i) {
                    final item = productController.isSearch.value
                        ? productController.searchItems[i]
                        : productController.products[i];
                    return SwipeActionCell(
                      key: ValueKey(item.id),
                      trailingActions: [
                        SwipeAction(
                          onTap: (CompletionHandler _) async {
                            await _(true);
                            await productController.delete(item.id);
                          },
                          title: 'Delete',
                        ),
                        SwipeAction(
                          color: Colors.grey,
                          onTap: (CompletionHandler _) async {
                            await _(false);
                            dataController.setEditProduct(item);
                            productController.configureForEditProduct(item);
                            Get.to(() => const UploadProduct());
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
                                imageUrl: item.images.first,
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
                                      "${item.price}Ks",
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
                  }),
            ),
          )
        ],
      ),
    );
  }
}
