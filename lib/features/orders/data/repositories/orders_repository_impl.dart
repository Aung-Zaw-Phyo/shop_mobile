import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:shop_mobile/core/error/exception.dart';
import 'package:shop_mobile/core/error/failure.dart';
import 'package:shop_mobile/features/orders/data/data_sources/remote_data_source.dart';
import 'package:shop_mobile/features/orders/domain/entities/order_details.dart';
import 'package:shop_mobile/features/orders/domain/entities/orders_data.dart';
import 'package:shop_mobile/features/orders/domain/repositories/orders_repository.dart';

class OrdersRepositoryImpl extends OrdersRepository {
  final OrdersRemoteDataSource _ordersRemoteDataSource;
  OrdersRepositoryImpl(this._ordersRemoteDataSource);

  @override
  Future<Either<Failure, OrdersDataEntity>> getOrders(int page) async {
    try {
      final result = await _ordersRemoteDataSource.getOrders(page);
      return right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.messages));
    } on SocketException {
      return const Left(
          ConnectionFailure(['Failed to connect to the internet']));
    }
  }

  @override
  Future<Either<Failure, OrderDetailsEntity>> getOrderDetails(
    int orderId,
  ) async {
    try {
      final result = await _ordersRemoteDataSource.getOrderDetails(orderId);
      return right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.messages));
    } on SocketException {
      return const Left(
          ConnectionFailure(['Failed to connect to the internet']));
    }
  }
}
