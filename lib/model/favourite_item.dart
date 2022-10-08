import 'package:hive/hive.dart';

part 'favourite_item.g.dart';

@HiveType(typeId: 0)
class FavouriteItem {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String image;
  @HiveField(3)
  final int price;
  FavouriteItem({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
  });
}
