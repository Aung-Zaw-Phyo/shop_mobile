import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:shop_mobile/core/error/exception.dart';
import 'package:shop_mobile/core/error/failure.dart';
import 'package:shop_mobile/features/auth/data/data_sources/remote_data_source.dart';
import 'package:shop_mobile/features/auth/domain/entities/user.dart';
import 'package:shop_mobile/features/auth/domain/repositories/auth_repositor.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  AuthRepositoryImpl(this._authRemoteDataSource);

  @override
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final result =
          await _authRemoteDataSource.login(email: email, password: password);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.messages));
    } on SocketException {
      return const Left(
          ConnectionFailure(['Failed to connect to the internet']));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final result = await _authRemoteDataSource.register(
          name: name, email: email, password: password);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.messages));
    } on SocketException {
      return const Left(
          ConnectionFailure(['Failed to connect to the internet']));
    }
  }
}
