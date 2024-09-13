import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class UpdateProfileEvent extends Equatable {
  const UpdateProfileEvent();

  @override
  List<Object?> get props => [];
}

class UpdateProfile extends UpdateProfileEvent {
  final String name;
  final String email;
  final File? image;
  const UpdateProfile({required this.name, required this.email, this.image});

  @override
  List<Object?> get props => [name, email, image];
}
