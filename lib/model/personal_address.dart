import 'package:freezed_annotation/freezed_annotation.dart';

part 'personal_address.freezed.dart';
part 'personal_address.g.dart';

@freezed
class PersonalAddress with _$PersonalAddress {
  factory PersonalAddress({
    required String fullName,
    required int phoneNumber,
    required String address,
    required int zipCode,
    required String country,
    required String city,
    required String district,
    required int addressType,
  }) = _PersonalAddress;

  factory PersonalAddress.fromJson(Map<String, dynamic> json) =>
      _$PersonalAddressFromJson(json);
}
