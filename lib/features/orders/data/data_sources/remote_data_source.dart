import 'package:dio/dio.dart';
import 'package:shop_mobile/core/constants/constants.dart';
import 'package:shop_mobile/core/error/exception.dart';
import 'package:shop_mobile/core/helper.dart';
import 'package:shop_mobile/features/orders/data/models/order_details_model.dart';
import 'package:shop_mobile/features/orders/data/models/order_model.dart';
import 'package:shop_mobile/features/orders/data/models/orders_data_model.dart';

abstract class OrdersRemoteDataSource {
  Future<OrdersDataModel> getOrders(int page);
  Future<OrderDetailsModel> getOrderDetails(int orderId);
}

class OrdersRemoteDataSourceImpl extends OrdersRemoteDataSource {
  final Dio _dio;
  OrdersRemoteDataSourceImpl(this._dio);

  @override
  Future<OrdersDataModel> getOrders(int page) async {
    final prefs = await sharedPrefs();
    final token = prefs.getString('token');
    _dio.options.headers['Authorization'] = 'Bearer $token';

    final response = await _dio.get(
        '${Constant.baseUrl}/orders?page=$page&limit=${Constant.paginateItemsLimit}');

    if (response.statusCode == 200) {
      List<OrderModel> orders = response.data['data']['items']
          .map<OrderModel>(
              (dynamic i) => OrderModel.fromJson(i as Map<String, dynamic>))
          .toList();
      final ordersData = OrdersDataModel(
        currentPage: response.data['data']['meta']['currentPage'],
        totalPages: response.data['data']['meta']['totalPages'],
        orders: orders,
      );
      return ordersData;
    } else {
      final messages = response.data['messages'] == null
          ? ['Something wrong!']
          : (response.data['messages'] as List<dynamic>).cast<String>();
      throw ServerException(messages);
    }
  }

  @override
  Future<OrderDetailsModel> getOrderDetails(int orderId) async {
    final prefs = await sharedPrefs();
    final token = prefs.getString('token');
    _dio.options.headers['Authorization'] = 'Bearer $token';

    final response = await _dio.get('${Constant.baseUrl}/orders/$orderId');

    if (response.statusCode == 200) {
      final order = OrderDetailsModel.fromJson(response.data['data']);
      return order;
    } else {
      final messages = response.data['messages'] == null
          ? ['Something wrong!']
          : (response.data['messages'] as List<dynamic>).cast<String>();
      throw ServerException(messages);
    }
  }
}
