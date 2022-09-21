import 'package:freezed_annotation/freezed_annotation.dart';

part 'time_sale.freezed.dart';
part 'time_sale.g.dart';

@freezed
class TimeSale with _$TimeSale {
  factory TimeSale({
    required String id,
    required String image,
    required DateTime startDate,
    required DateTime endDate,
  }) = _TimeSale;

  factory TimeSale.fromJson(Map<String, dynamic> json) =>
      _$TimeSaleFromJson(json);
}
