import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/product.dart';
import '../utils/widgets/loading_widget.dart';

class SelectableProducts extends StatelessWidget {
  const SelectableProducts({
    Key? key,
    required this.list,
    required this.selectedObxMap,
    required this.pressedCancelButton,
    required this.pressedSaveButton,
    required this.selectedProduct,
    required this.isLoading,
    required this.isFetchMoreLoading,
    required this.scrollController,
    required this.title,
  }) : super(key: key);

  final RxList<Product> list;
  final String title;
  final RxBool isLoading;
  final RxBool isFetchMoreLoading;
  final RxMap<String, Product> selectedObxMap;
  final void Function(Product product) selectedProduct;
  final void Function() pressedCancelButton;
  final void Function() pressedSaveButton;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        pressedCancelButton();
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
          title: Center(
              child: Text(
            title,
            style: const TextStyle(
              color: Colors.black,
            ),
          )),
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 10,
                right: 10,
              ),
              child: ElevatedButton(
                onPressed: () => pressedSaveButton(),
                child: const Text("Save"),
              ),
            )
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Obx(() {
                  if (isLoading.value) {
                    return const LoadingWidget();
                  }
                  return ListView.builder(
                    controller: scrollController,
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      final product = list[index];

                      return Obx(() {
                        final map = selectedObxMap;
                        final isSelected = map.containsKey(product.id);
                        return CheckboxListTile(
                          value: isSelected,
                          onChanged: (b) => selectedProduct(product),
                          title: Text(product.name,
                              style: const TextStyle(
                                color: Colors.black,
                              )),
                        );
                      });
                    },
                  );
                }),
              ),
              Obx(() => isFetchMoreLoading.value
                  ? AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                      height: 35,
                      width: 35,
                      child: const CircularProgressIndicator(),
                    )
                  : const SizedBox()),
              /* SizedBox(
                  height: 50,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Get.back();
                            pressedCancelButton();
                          },
                          child: const Text("Cancel"),
                        ),
                        const SizedBox(width: 15),
                        ElevatedButton(
                          onPressed: () => pressedSaveButton(),
                          child: const Text("Save"),
                        ),
                      ])), */
            ],
          ),
        ),
      ),
    );
  }
}
