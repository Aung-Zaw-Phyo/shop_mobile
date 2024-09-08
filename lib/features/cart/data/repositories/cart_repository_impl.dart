import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:shop_mobile/core/error/exception.dart';
import 'package:shop_mobile/core/error/failure.dart';
import 'package:shop_mobile/features/cart/data/data_sources/remote_data_source.dart';
import 'package:shop_mobile/features/cart/domain/entities/shipping_address.dart';
import 'package:shop_mobile/features/cart/domain/repositories/cart_repository.dart';
import 'package:shop_mobile/features/cart/domain/entities/cart.dart';

class CartRepositoryImpl extends CartRepository {
  final CartRemoteDataSource _cartRemoteDataSource;
  CartRepositoryImpl(this._cartRemoteDataSource);

  @override
  Future<Either<Failure, CartEntity>> getCart() async {
    try {
      final result = await _cartRemoteDataSource.getCart();
      return right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.messages));
    } on SocketException {
      return const Left(
          ConnectionFailure(['Failed to connect to the internet']));
    }
  }

  @override
  Future<Either<Failure, CartEntity>> addItem({
    required int quantity,
    required int variantId,
  }) async {
    try {
      final result = await _cartRemoteDataSource.addItem(
        quantity: quantity,
        variantId: variantId,
      );
      return right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.messages));
    } on SocketException {
      return const Left(
          ConnectionFailure(['Failed to connect to the internet']));
    }
  }

  @override
  Future<Either<Failure, CartEntity>> removeItem({
    required int quantity,
    required int variantId,
  }) async {
    try {
      final result = await _cartRemoteDataSource.removeItem(
        quantity: quantity,
        variantId: variantId,
      );
      return right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.messages));
    } on SocketException {
      return const Left(
          ConnectionFailure(['Failed to connect to the internet']));
    }
  }

  @override
  Future<Either<Failure, String>> createPayment({
    required ShippingAddressEntity shippingAddress,
  }) async {
    try {
      final result = await _cartRemoteDataSource.createPayment(
        shippingAddress: shippingAddress.toModel(),
      );
      return right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.messages));
    } on SocketException {
      return const Left(
          ConnectionFailure(['Failed to connect to the internet']));
    }
  }
}
