import 'package:freezed_annotation/freezed_annotation.dart';

part 'main_category.freezed.dart';
part 'main_category.g.dart';

@freezed
class MainCategory with _$MainCategory {
  factory MainCategory({
    required String id,
    required String name,
    required String image,
    @JsonKey(defaultValue: false) required bool isMenu,
    required DateTime dateTime,
  }) = _MainCategory;

  factory MainCategory.fromJson(Map<String, dynamic> json) =>
      _$MainCategoryFromJson(json);
}
