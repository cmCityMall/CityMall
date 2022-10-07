import 'package:citymall/productdetailsscreen/product_detail_controller.dart';
import 'package:get/get.dart';

class ProductDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProductDetailController());
  }
}
