import 'package:shop_mobile/features/profile/domain/entities/profile.dart';

class ProfileModel extends ProfileEntity {
  const ProfileModel({
    required int id,
    required String name,
    required String email,
    required String image,
  }) : super(
          id: id,
          name: name,
          email: email,
          image: image,
        );

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        image: json['image'],
      );
}
