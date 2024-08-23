import 'package:dio/dio.dart';
import 'package:shop_mobile/core/constants/constants.dart';
import 'package:shop_mobile/core/error/exception.dart';
import 'package:shop_mobile/features/auth/data/models/user.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login({required String email, required String password});
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final Dio _dio;
  AuthRemoteDataSourceImpl(this._dio);

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final response = await _dio.post('${Constant.baseUrl}/users/login',
        data: {"email": email, "password": password});

    if (response.statusCode == 201) {
      final user = UserModel.fromJson(response.data['data']);
      return user;
    } else {
      final messages = response.data['messages'] == null
          ? ['Something wrong!']
          : (response.data['messages'] as List<dynamic>).cast<String>();
      throw ServerException(messages);
    }
  }

  @override
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await _dio.post(
      '${Constant.baseUrl}/users/register',
      data: {"name": name, "email": email, "password": password},
    );

    if (response.statusCode == 201) {
      final user = UserModel.fromJson(response.data['data']);
      return user;
    } else {
      final messages = response.data['messages'] == null
          ? ['Something wrong!']
          : (response.data['messages'] as List<dynamic>).cast<String>();
      throw ServerException(messages);
    }
  }
}
