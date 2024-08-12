import 'package:dio/dio.dart';
import 'package:shop_mobile/core/constants/constants.dart';

final Dio dio_client = Dio(BaseOptions(
  baseUrl: Constant.baseUrl,
  connectTimeout: const Duration(seconds: 15),
  receiveTimeout: const Duration(seconds: 15),
  headers: {
    "Content-Type": "application/json",
    'Accept': 'application/json',
  },
  validateStatus: (status) => status! <= 500,
));
