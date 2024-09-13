import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final int id;
  final String name;
  final String email;
  final String image;
  const ProfileEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.image,
  });

  @override
  List<Object?> get props => [id, name, email, image];
}
