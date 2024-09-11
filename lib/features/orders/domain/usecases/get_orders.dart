import 'package:dartz/dartz.dart';
import 'package:shop_mobile/core/error/failure.dart';
import 'package:shop_mobile/features/orders/domain/entities/orders_data.dart';
import 'package:shop_mobile/features/orders/domain/repositories/orders_repository.dart';

class GetOrdersUseCase {
  final OrdersRepository _ordersRepository;
  const GetOrdersUseCase(this._ordersRepository);

  Future<Either<Failure, OrdersDataEntity>> execute(int page) {
    return _ordersRepository.getOrders(page);
  }
}
