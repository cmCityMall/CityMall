import 'package:freezed_annotation/freezed_annotation.dart';

part 'week_promotion.freezed.dart';
part 'week_promotion.g.dart';

@freezed
class WeekPromotion with _$WeekPromotion {
  factory WeekPromotion({
    required String id,
    required String image,
    required String desc,
    required bool isPercentage,
    int? percentage,
    int? descountPrice,
     DateTime? dateTime,
  }) = _WeekPromotion;

  factory WeekPromotion.fromJson(Map<String, dynamic> json) =>
      _$WeekPromotionFromJson(json);
}
