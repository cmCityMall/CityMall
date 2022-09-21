import 'package:json_annotation/json_annotation.dart';

import '../constant/mock.dart';

part 'auth_user.g.dart';

@JsonSerializable()
class AuthUser {
  final String id;
  final String emailAddress;
  final String userName;
  final String image;
  final int points;
  final int? status;
  final String token;
  AuthUser({
    required this.id,
    required this.emailAddress,
    required this.userName,
    required this.image,
    required this.points,
    this.status = 0,
    required this.token,
  });

  factory AuthUser.fromJson(Map<String, dynamic> json) =>
      _$AuthUserFromJson(json);

  Map<String, dynamic> toJson() => _$AuthUserToJson(this);

  factory AuthUser.guest() => AuthUser(
        id: "guestId",
        emailAddress: "guest@gmail.com",
        userName: "Guest",
        image: mockProfile,
        points: 0,
        status: 0,
        token: "testToken",
      );
}
