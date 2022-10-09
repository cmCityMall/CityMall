import 'dart:developer';

import 'package:citymall/model/cart_product.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  RxMap<String, CartProduct> cartMap = <String, CartProduct>{}.obs;
  var subTotal = 0.obs;
  String? townshipName; //Township Name
  Map<String, dynamic> townShipNameAndFee = {}; //Township Name and Fee
  int mouseIndex = -1; //Mouse Region

  void changeMouseIndex(int i) {
    // Change Mouse Region
    mouseIndex = i;
    update();
  }

  //Set Shipping Fee
  void setTownshipName(String? val) {
    townshipName = val!;
    update();
  }

  //Set Township Name
  void setTownShipNameAndShip({required String name, required String fee}) {
    townShipNameAndFee = {
      "townName": name,
      "fee": int.parse(fee),
    };
    update();
  }

  void addIntoCart(CartProduct cartProduct) {
    if (cartMap.containsKey(cartProduct.id)) {
      //If Already contain,increase count
      final lastCartProduct = cartMap[cartProduct.id];
      cartMap[cartProduct.id] = lastCartProduct!.copyWith(
        count: lastCartProduct.count + 1,
      );
    } else {
      //Else add count to 1
      cartMap.putIfAbsent(cartProduct.id, () => cartProduct.copyWith(count: 1));
    }
  }

  void removeFromCart(String id) {
    final count = cartMap[id]!.count;
    if (count == 1) {
      //if count is 1 and user press -,so need to remove
      cartMap.remove(id);
    } else {
      //Else only need to reduce
      cartMap[id] = cartMap[id]!.copyWith(count: count - 1);
    }
  }

  @override
  void onInit() {
    ever(cartMap, updatePrice);
    super.onInit();
  }

  updatePrice(Map<String, CartProduct> cart) {
    log("*****Cart Change and Update Price...");
    subTotal.value = 0;
    for (var element in cart.entries) {
      subTotal.value =
          subTotal.value + (element.value.lastPrice * element.value.count);
    }
  }
}
