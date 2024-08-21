import 'package:dartz/dartz.dart';
import 'package:shop_mobile/core/error/failure.dart';
import 'package:shop_mobile/features/cart/domain/entities/cart.dart';

abstract class CartRepository {
  Future<Either<Failure, CartEntity>> getCart();
}
