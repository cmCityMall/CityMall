import 'package:cached_network_image/cached_network_image.dart';
import 'package:citymall/colors/colors.dart';
import 'package:citymall/controller/auth_controller.dart';
import 'package:citymall/controller/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/reward_product.dart';

class RewardProductWidget extends StatelessWidget {
  final RewardProduct product;
  const RewardProductWidget({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find();
    final AuthController authController = Get.find();
    return InkWell(
      onTap: () {
        //TODO: GO TO DETAIL PAGE
      },
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxHeight: 100,
        ),
        child: Card(
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  flex: 1,
                  child: Hero(
                    tag: product.image,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: CachedNetworkImage(
                        imageUrl: product.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            product.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 5,
                            right: 5,
                            bottom: 10,
                            top: 2,
                          ),
                          child: Text(
                            "${product.requiredPoint} Points",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //BUTTOM
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Obx(() {
                    return Align(
                      alignment: Alignment.bottomCenter,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                side: BorderSide(
                                  color:
                                      (authController.currentUser.value!.id ==
                                              "guestId")
                                          ? Colors.black
                                          : ColorResources.blue,
                                ))),
                        onPressed: () {
                          if (authController.currentUser.value == null) {
                            authController.googleSingIn();
                          } else {
                            debugPrint("*****Add to cart reward product**");
                            if (!((cartController.rewardCartMap
                                .containsKey(product.id)))) {
                              cartController.addToRewardCart(product);
                            }
                          }
                        },
                        child:
                            (authController.currentUser.value!.id == "guestId")
                                ? const Text("sign in to access",
                                    style: TextStyle(
                                      color: Colors.black,
                                    ))
                                : Text(
                                    (cartController.rewardCartMap
                                            .containsKey(product.id))
                                        ? "Added"
                                        : "Add to cart",
                                    style: const TextStyle(
                                      color: ColorResources.blue,
                                    )),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
