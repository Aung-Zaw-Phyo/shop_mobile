import 'package:dartz/dartz.dart';
import 'package:shop_mobile/core/error/failure.dart';
import 'package:shop_mobile/features/auth/domain/entities/user.dart';
import 'package:shop_mobile/features/auth/domain/repositories/auth_repositor.dart';

class RegisterUseCase {
  final AuthRepository _authRepository;
  const RegisterUseCase(this._authRepository);

  Future<Either<Failure, UserEntity>> execute({
    required String name,
    required String email,
    required String password,
  }) {
    return _authRepository.register(
      name: name,
      email: email,
      password: password,
    );
  }
}
