import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../../widgets/form/custon_swich.dart';
import '../../../widgets/form/image_pick_form.dart';
import '../../../widgets/form/text_form.dart';
import '../controller/mc_controller.dart';

class MCView extends StatelessWidget {
  const MCView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MCController mcController = Get.find();
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
          title: const Center(
              child: Text(
            "Main Categories",
            style: TextStyle(
              color: Colors.black,
            ),
          )),
        ),
        body: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 16.0,
            ),
            child: Form(
              key: mcController.formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /**Form*/
                    CustomTextForm(
                      padding: 0,
                      rightPadding: 40,
                      height: 85,
                      textFieldPaddingLeft: 10,
                      controller: mcController.nameController,
                      isUnderlineBorder: false,
                      validator: mcController.validate,
                      labelText: "Ad Name",
                    ),
                    Obx(() {
                      final pickedImage = mcController.pickedImage.value;
                      final isEmpty = pickedImage.isEmpty;
                      return ImagePickForm(
                        labelText: isEmpty ? "pick an image" : pickedImage,
                        pickImage: () => mcController.pickImage(),
                      );
                    }),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 40,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text("Hot"),
                              const SizedBox(height: 5),
                              Obx(() {
                                final isHot = mcController.isMenu.value;
                                return CustomSwitch(
                                  value: isHot,
                                  onChanged: (value) =>
                                      mcController.changeIsMenu(value),
                                );
                              }),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () => mcController.save(),
                            child: const Text("Save"),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    /**Advertisement List*/
                    Expanded(
                      child: Obx(
                        () {
                          if (mcController.mainCategories.isEmpty) {
                            return const Center(
                                child: Text(
                              "No main categories yet....",
                            ));
                          }

                          return ListView.builder(
                            itemCount: mcController.mainCategories.length,
                            itemBuilder: (context, index) {
                              var advertisement =
                                  mcController.mainCategories[index];

                              return SwipeActionCell(
                                key: ValueKey(advertisement.id),
                                trailingActions: [
                                  SwipeAction(
                                    onTap: (CompletionHandler _) async {
                                      await _(true);
                                      await mcController
                                          .delete(advertisement.id);
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
                                    child: Row(
                                      children: [
                                        //Advertisement IMAGE
                                        Expanded(
                                          child: CachedNetworkImage(
                                            progressIndicatorBuilder:
                                                (context, url, status) {
                                              return Shimmer.fromColors(
                                                baseColor: Colors.grey,
                                                highlightColor: Colors.white,
                                                child: Container(
                                                  color: Colors.white,
                                                ),
                                              );
                                            },
                                            errorWidget:
                                                (context, url, whatever) {
                                              return const Text(
                                                  "Image not available");
                                            },
                                            imageUrl: advertisement.image,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        //Type
                                        Expanded(
                                          child: Text(
                                            advertisement.name,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ]),
            )));
  }
}
