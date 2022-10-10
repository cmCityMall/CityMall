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
    required double reviewCount,
    required int totalQuantity,
    required int remainQuantity,
    @JsonKey(nullable: true) String? barCode,
    @JsonKey(nullable: true) int? saleCount,
    @JsonKey(nullable: true) String? shopId,
    @JsonKey(nullable: true) String? brandId,
    @JsonKey(nullable: true) String? mainCategoryId,
    @JsonKey(nullable: true) List<String>? nameArray,
    required DateTime dateTime,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  factory Product.initial() => Product(
        id: '',
        name: '',
        images: [],
        description: '',
        price: 0,
        subCategoryId: '',
        reviewCount: 0.0,
        totalQuantity: 0,
        remainQuantity: 0,
        saleCount: 0,
        nameArray: [],
        dateTime: DateTime.now(),
      );
}
