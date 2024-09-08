import 'package:dartz/dartz.dart';
import 'package:shop_mobile/core/error/failure.dart';
import 'package:shop_mobile/features/cart/domain/entities/shipping_address.dart';
import 'package:shop_mobile/features/cart/domain/repositories/cart_repository.dart';

class CreatePaymentUseCase {
  final CartRepository _cartRepository;
  const CreatePaymentUseCase(this._cartRepository);

  Future<Either<Failure, String>> execute({
    required ShippingAddressEntity shippingAddress,
  }) {
    return _cartRepository.createPayment(shippingAddress: shippingAddress);
  }
}
