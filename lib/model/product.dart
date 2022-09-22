import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
class Product with _$Product {
  factory Product({
    required String id,
    required String name,
    required List<String> images,
    required String description,
    @JsonKey(nullable: true) Map<String, dynamic>? sizeColorImagePrice,
    required int price,
    @JsonKey(nullable: true) int? promotion,
    @JsonKey(nullable: true) String? promotionId,
    required String subCategoryId,
    required int reviewCount,
    required int totalQuantity,
    required int remainQuantity,
    @JsonKey(nullable: true) String? shopId,
    @JsonKey(nullable: true) String? brandId,
    @JsonKey(nullable: true) dynamic documentSnapshot,
    required DateTime dateTime,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}
