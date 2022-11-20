import 'package:freezed_annotation/freezed_annotation.dart';

part 'reward_product.freezed.dart';
part 'reward_product.g.dart';

@freezed
class RewardProduct with _$RewardProduct {
  factory RewardProduct({
    required String id,
    required String name,
    required String image,
    required String description,
    required int requiredPoint,
    required int count,
    required int totalQuantity,
    required int remainQuantity,
    @JsonKey(nullable: true) String? barCode,
    @JsonKey(nullable: true) List<String>? nameArray,
    required DateTime dateTime,
  }) = _RewardProduct;

  factory RewardProduct.fromJson(Map<String, dynamic> json) =>
      _$RewardProductFromJson(json);
}
