import 'package:dartz/dartz.dart';
import 'package:shop_mobile/core/error/failure.dart';
import 'package:shop_mobile/features/orders/domain/entities/order_details.dart';
import 'package:shop_mobile/features/orders/domain/repositories/orders_repository.dart';

class GetOrderDetailsUseCase {
  final OrdersRepository _ordersRepository;
  const GetOrderDetailsUseCase(this._ordersRepository);

  Future<Either<Failure, OrderDetailsEntity>> execute(int orderId) {
    return _ordersRepository.getOrderDetails(orderId);
  }
}
