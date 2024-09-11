import 'package:equatable/equatable.dart';
import 'package:shop_mobile/features/orders/domain/entities/order.dart';

class OrdersDataEntity extends Equatable {
  final int currentPage;
  final int totalPages;
  final List<OrderEntity> orders;

  const OrdersDataEntity({
    required this.currentPage,
    required this.totalPages,
    required this.orders,
  });

  @override
  List<Object> get props => [currentPage, totalPages, orders];
}
