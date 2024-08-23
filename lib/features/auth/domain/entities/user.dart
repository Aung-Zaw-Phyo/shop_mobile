import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String name;
  final String email;
  final String? image;
  final String? accessToken;
  const UserEntity({
    required this.name,
    required this.email,
    this.image,
    this.accessToken,
  });

  @override
  List<Object?> get props => [
        name,
        email,
        image,
        accessToken,
      ];
}
