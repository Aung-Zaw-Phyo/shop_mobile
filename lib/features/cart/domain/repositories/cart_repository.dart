import 'package:dartz/dartz.dart';
import 'package:shop_mobile/core/error/failure.dart';
import 'package:shop_mobile/features/cart/domain/entities/cart.dart';
import 'package:shop_mobile/features/cart/domain/entities/shipping_address.dart';

abstract class CartRepository {
  Future<Either<Failure, CartEntity>> getCart();
  Future<Either<Failure, CartEntity>> addItem({
    required int quantity,
    required int variantId,
  });
  Future<Either<Failure, CartEntity>> removeItem({
    required int quantity,
    required int variantId,
  });
  Future<Either<Failure, String>> createPayment({
    required ShippingAddressEntity shippingAddress,
  });
  Future<Either<Failure, int>> checkPayment({
    required String sessionId,
  });
}
