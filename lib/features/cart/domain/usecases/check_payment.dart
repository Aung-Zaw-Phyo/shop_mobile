import 'package:dartz/dartz.dart';
import 'package:shop_mobile/core/error/failure.dart';
import 'package:shop_mobile/features/cart/domain/repositories/cart_repository.dart';

class CheckPaymentUseCase {
  final CartRepository _cartRepository;
  const CheckPaymentUseCase(this._cartRepository);

  Future<Either<Failure, int>> execute({
    required String sessionId,
  }) {
    return _cartRepository.checkPayment(sessionId: sessionId);
  }
}
