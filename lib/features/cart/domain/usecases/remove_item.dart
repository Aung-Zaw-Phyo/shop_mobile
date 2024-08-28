import 'package:dartz/dartz.dart';
import 'package:shop_mobile/core/error/failure.dart';
import 'package:shop_mobile/features/cart/domain/entities/cart.dart';
import 'package:shop_mobile/features/cart/domain/repositories/cart_repository.dart';

class RemoveItemUseCase {
  final CartRepository _cartRepository;
  const RemoveItemUseCase(this._cartRepository);

  Future<Either<Failure, CartEntity>> execute({
    required int quantity,
    required int variantId,
  }) {
    return _cartRepository.removeItem(
      quantity: quantity,
      variantId: variantId,
    );
  }
}
