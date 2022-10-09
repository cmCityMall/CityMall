import 'package:hive/hive.dart';

part 'hive_personal_address.g.dart';

@HiveType(typeId: 2)
class HivePersonalAddress {
  @HiveField(0)
  final String fullName;
  @HiveField(1)
  final String address;
  @HiveField(2)
  final int zipCode;
  @HiveField(3)
  final String country;
  @HiveField(4)
  final String city;
  @HiveField(5)
  final String district;
  @HiveField(6)
  final int addressType;
  @HiveField(7)
  final String id;
  @HiveField(8)
  final int phoneNumber;
  HivePersonalAddress({
    required this.fullName,
    required this.address,
    required this.country,
    required this.city,
    required this.zipCode,
    required this.district,
    required this.addressType,
    required this.id,
    required this.phoneNumber,
  });
}
