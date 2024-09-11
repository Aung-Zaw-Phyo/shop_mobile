import 'package:dio/dio.dart';
import 'package:shop_mobile/core/error/exception.dart';
import 'package:shop_mobile/core/helper.dart';
import 'package:shop_mobile/features/cart/data/models/cart_model.dart';
import 'package:shop_mobile/features/cart/data/models/shipping_address_model.dart';

abstract class CartRemoteDataSource {
  Future<CartModel> getCart();
  Future<CartModel> addItem({required int quantity, required int variantId});
  Future<CartModel> removeItem({required int quantity, required int variantId});
  Future<String> createPayment({required ShippingAddressModel shippingAddress});
  Future<int> checkPayment({required String sessionId});
}

class CartRemoteDataSourceImpl extends CartRemoteDataSource {
  final Dio _dio;
  CartRemoteDataSourceImpl(this._dio);

  @override
  Future<CartModel> getCart() async {
    final prefs = await sharedPrefs();
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

  @override
  Future<CartModel> addItem({
    required int quantity,
    required int variantId,
  }) async {
    final prefs = await sharedPrefs();
    final token = prefs.getString('token');
    _dio.options.headers['Authorization'] = 'Bearer $token';
    final response = await _dio.post('/carts/add-item', data: {
      "quantity": quantity,
      "variantId": variantId,
    });
    if (response.statusCode == 201) {
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

  @override
  Future<CartModel> removeItem(
      {required int quantity, required int variantId}) async {
    final prefs = await sharedPrefs();
    final token = prefs.getString('token');
    _dio.options.headers['Authorization'] = 'Bearer $token';
    final response = await _dio.post('/carts/remove-item', data: {
      "quantity": quantity,
      "variantId": variantId,
    });
    if (response.statusCode == 201) {
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

  @override
  Future<String> createPayment({
    required ShippingAddressModel shippingAddress,
  }) async {
    final prefs = await sharedPrefs();
    final token = prefs.getString('token');
    _dio.options.headers['Authorization'] = 'Bearer $token';

    final response = await _dio.post(
      '/stripe/create-payment-intents',
      data: shippingAddress.toJson(),
    );

    if (response.statusCode == 201) {
      return response.data['data'];
    } else {
      final messages = response.data['messages'] == null
          ? ['Something wrong!']
          : (response.data['messages'] as List<dynamic>).cast<String>();
      throw ServerException(messages);
    }
  }

  @override
  Future<int> checkPayment({
    required String sessionId,
  }) async {
    final prefs = await sharedPrefs();
    final token = prefs.getString('token');
    _dio.options.headers['Authorization'] = 'Bearer $token';

    final response = await _dio.get(
      '/orders/check/$sessionId',
    );

    if (response.statusCode == 200) {
      return response.data['data'];
    } else {
      final messages = response.data['messages'] == null
          ? ['Something wrong!']
          : (response.data['messages'] as List<dynamic>).cast<String>();
      throw ServerException(messages);
    }
  }
}
