import 'package:freezed_annotation/freezed_annotation.dart';

part 'shop.freezed.dart';
part 'shop.g.dart';

@freezed
class Shop with _$Shop {
  factory Shop({
    required String id,
    required String image,
    required String name,
    required DateTime dateTime,
    @JsonKey(nullable: true) dynamic documentSnapshot,
  }) = _Shop;

  factory Shop.fromJson(Map<String, dynamic> json) => _$ShopFromJson(json);
}
