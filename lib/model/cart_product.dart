import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_product.freezed.dart';
part 'cart_product.g.dart';

@freezed
class CartProduct with _$CartProduct {
  factory CartProduct({
    required String id,
    required String name,
    required String image,
    required int lastPrice,
    required String? color,
    required String? size,
    required int count,
  }) = _CartProduct;
  factory CartProduct.fromJson(Map<String, dynamic> json) =>
      _$CartProductFromJson(json);
}
