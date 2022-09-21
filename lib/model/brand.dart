import 'package:freezed_annotation/freezed_annotation.dart';

part 'brand.freezed.dart';
part 'brand.g.dart';

@freezed
class Brand with _$Brand {
  factory Brand({
    required String id,
    required String name,
    required String image,
    @JsonKey(nullable: true) String? shopId,
    required DateTime dateTime,
    @JsonKey(nullable: true) dynamic documentSnapshot,
  }) = _Brand;

  factory Brand.fromJson(Map<String, dynamic> json) => _$BrandFromJson(json);
}
