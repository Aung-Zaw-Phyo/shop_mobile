import 'package:dartz/dartz.dart';
import 'package:shop_mobile/core/error/failure.dart';
import 'package:shop_mobile/features/auth/domain/entities/user.dart';
import 'package:shop_mobile/features/auth/domain/repositories/auth_repositor.dart';

class LoginUseCase {
  final AuthRepository _authRepository;
  const LoginUseCase(this._authRepository);

  Future<Either<Failure, UserEntity>> execute({
    required String email,
    required String password,
  }) {
    return _authRepository.login(email: email, password: password);
  }
}
