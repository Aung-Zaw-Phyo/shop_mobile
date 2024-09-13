import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shop_mobile/core/constants/constants.dart';
import 'package:shop_mobile/core/error/exception.dart';
import 'package:shop_mobile/core/helper.dart';
import 'package:shop_mobile/features/profile/data/models/profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel> getProfile();
  Future<ProfileModel> updateProfile({
    required String name,
    required String email,
    File? image,
  });
}

class ProfileRemoteDataSourceImpl extends ProfileRemoteDataSource {
  final Dio _dio;
  ProfileRemoteDataSourceImpl(this._dio);

  @override
  Future<ProfileModel> getProfile() async {
    final prefs = await sharedPrefs();
    final token = prefs.getString('token');
    _dio.options.headers['Authorization'] = 'Bearer $token';

    final response = await _dio.get('${Constant.baseUrl}/users/profile');

    if (response.statusCode == 200) {
      final profile = ProfileModel.fromJson(response.data['data']);
      return profile;
    } else {
      final messages = response.data['messages'] == null
          ? ['Something wrong!']
          : (response.data['messages'] as List<dynamic>).cast<String>();
      throw ServerException(messages);
    }
  }

  @override
  Future<ProfileModel> updateProfile({
    required String name,
    required String email,
    File? image,
  }) async {
    final prefs = await sharedPrefs();
    final token = prefs.getString('token');
    _dio.options.headers['Authorization'] = 'Bearer $token';
    var formData = FormData.fromMap({
      'name': name,
      'email': email,
      'image': image != null ? await MultipartFile.fromFile(image.path) : null,
    });
    final response = await _dio.put(
      '${Constant.baseUrl}/users',
      data: formData,
    );

    if (response.statusCode == 200) {
      final profile = ProfileModel.fromJson(response.data['data']);
      return profile;
    } else {
      final messages = response.data['messages'] == null
          ? ['Something wrong!']
          : (response.data['messages'] as List<dynamic>).cast<String>();
      throw ServerException(messages);
    }
  }
}
