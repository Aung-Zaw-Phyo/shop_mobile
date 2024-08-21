import 'package:dio/dio.dart';
import 'package:shop_mobile/core/error/exception.dart';
import 'package:shop_mobile/core/helper.dart';
import 'package:shop_mobile/features/cart/data/models/cart_model.dart';

abstract class CartRemoteDataSource {
  Future<CartModel> getCart();
}

class CartRemoteDataSourceImpl extends CartRemoteDataSource {
  final Dio _dio;
  CartRemoteDataSourceImpl(this._dio);

  @override
  Future<CartModel> getCart() async {
    final prefs = await sharedPrefs();
    prefs.setString('token',
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTcsImVtYWlsIjoiYXVuZ3phd3BoeW9AZ21haWwuY29tIiwiaWF0IjoxNzI0MTcyMTkxLCJleHAiOjE3MjQyMDgxOTF9.o5nVPTEuBIbFCWlweyyi-SDmO7CY8yjfMq6v7BdHwrA');
    final token = prefs.getString('token');
    _dio.options.headers['Authorization'] = 'Bearer $token';
    final response = await _dio.get('/carts');
    if (response.statusCode == 200) {
      final cart =
          CartModel.fromJson(response.data['data'] as Map<String, dynamic>);
      return cart;
    } else {
      final messages = response.data['messages'] == null
          ? ['Something wrong!']
          : (response.data['messages'] as List<dynamic>).cast<String>();
      throw ServerException(messages);
    }
  }
}
