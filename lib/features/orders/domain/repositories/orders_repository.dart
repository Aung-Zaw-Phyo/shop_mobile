import 'package:dartz/dartz.dart';
import 'package:shop_mobile/core/error/failure.dart';
import 'package:shop_mobile/features/orders/domain/entities/order_details.dart';
import 'package:shop_mobile/features/orders/domain/entities/orders_data.dart';

abstract class OrdersRepository {
  Future<Either<Failure, OrdersDataEntity>> getOrders(int page);
  Future<Either<Failure, OrderDetailsEntity>> getOrderDetails(int orderId);
}
