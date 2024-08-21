import 'package:dartz/dartz.dart';
import 'package:shop_mobile/core/error/failure.dart';
import 'package:shop_mobile/features/cart/domain/entities/cart.dart';
import 'package:shop_mobile/features/cart/domain/repositories/cart_repository.dart';

class GetCartUseCase {
  final CartRepository _cartRepository;
  const GetCartUseCase(this._cartRepository);

  Future<Either<Failure, CartEntity>> execute() {
    return _cartRepository.getCart();
  }
}
