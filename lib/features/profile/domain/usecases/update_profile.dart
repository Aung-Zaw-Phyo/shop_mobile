import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:shop_mobile/core/error/failure.dart';
import 'package:shop_mobile/features/profile/domain/entities/profile.dart';
import 'package:shop_mobile/features/profile/domain/repositories/profile_repository.dart';

class UpdateProfileUseCase {
  final ProfileRepository _profileRepository;
  UpdateProfileUseCase(this._profileRepository);

  Future<Either<Failure, ProfileEntity>> execute({
    required String name,
    required String email,
    File? image,
  }) {
    return _profileRepository.updateProfile(
      name: name,
      email: email,
      image: image,
    );
  }
}
