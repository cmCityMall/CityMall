import 'package:hive/hive.dart';

part 'favourite_item.g.dart';

@HiveType(typeId: 3)
class FavouriteItem {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final List<String> images;
  @HiveField(3)
  final String description;
  @HiveField(4)
  final Map<String, dynamic>? sizeColorImagePrice;
  @HiveField(5)
  final int price;
  @HiveField(6)
  final int? promotion;
  @HiveField(7)
  final String? promotionId;
  @HiveField(8)
  final String subCategoryId;
  @HiveField(9)
  final double reviewCount;
  @HiveField(10)
  final int totalQuantity;
  @HiveField(11)
  final int remainQuantity;
  @HiveField(12)
  final String? barCode;
  @HiveField(13)
  final int? saleCount;
  @HiveField(14)
  final String? shopId;
  @HiveField(15)
  final String? brandId;
  @HiveField(16)
  final String? mainCategoryId;
  @HiveField(17)
  final List<String>? nameArray;
  @HiveField(18)
  final DateTime dateTime;
  @HiveField(19)
  final String productType;
  FavouriteItem({
    required this.id,
    required this.barCode,
    required this.brandId,
    required this.dateTime,
    required this.description,
    required this.images,
    required this.mainCategoryId,
    required this.name,
    required this.nameArray,
    required this.price,
    required this.productType,
    required this.promotion,
    required this.promotionId,
    required this.remainQuantity,
    required this.reviewCount,
    required this.saleCount,
    required this.shopId,
    required this.sizeColorImagePrice,
    required this.subCategoryId,
    required this.totalQuantity,
  });
}
