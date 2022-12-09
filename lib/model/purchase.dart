import 'package:citymall/model/personal_address.dart';
import 'package:citymall/model/reward_product.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'cart_product.dart';

part 'purchase.freezed.dart';
part 'purchase.g.dart';

@freezed
class Purchase with _$Purchase {
  @JsonSerializable(explicitToJson: true)
  factory Purchase({
    required String id,
    List<CartProduct>? items,
    List<RewardProduct>? rewardProducts,
    required PersonalAddress personalAddress,
    required String screenShotImage,
    required Map<String, dynamic> townShipNameAndFee,
    required String userId,
    required int status,
    required String eta,
    required DateTime dateTime,
  }) = _Purchase;
  factory Purchase.fromJson(Map<String, dynamic> json) =>
      _$PurchaseFromJson(json);
}
