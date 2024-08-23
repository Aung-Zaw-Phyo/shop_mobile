import 'package:shop_mobile/features/auth/domain/entities/user.dart';

class UserModel extends UserEntity {
  const UserModel({
    required String name,
    required String email,
    String? image,
    String? accessToken,
  }) : super(
          name: name,
          email: email,
          image: image,
          accessToken: accessToken,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json['name'],
        email: json['email'],
        image: json['image'],
        accessToken: json['access_token'],
      );
}
