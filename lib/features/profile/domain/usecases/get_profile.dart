import 'package:dartz/dartz.dart';
import 'package:shop_mobile/core/error/failure.dart';
import 'package:shop_mobile/features/profile/domain/entities/profile.dart';
import 'package:shop_mobile/features/profile/domain/repositories/profile_repository.dart';

class GetProfileUseCase {
  final ProfileRepository _profileRepository;
  GetProfileUseCase(this._profileRepository);

  Future<Either<Failure, ProfileEntity>> execute() {
    return _profileRepository.getProfile();
  }
}
