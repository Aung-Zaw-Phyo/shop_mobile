import 'package:equatable/equatable.dart';
import 'package:shop_mobile/features/orders/domain/entities/order_item.dart';
import 'package:shop_mobile/features/orders/domain/entities/shipping_address.dart';

class OrderDetailsEntity extends Equatable {
  final int id;
  final String orderNumber;
  final int totalAmount;
  final String status;
  final ShippingAddressEntity shippingAddress;
  final List<OrderItemEntity> items;
  final String createdAt;

  const OrderDetailsEntity({
    required this.id,
    required this.orderNumber,
    required this.totalAmount,
    required this.status,
    required this.shippingAddress,
    required this.items,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        orderNumber,
        totalAmount,
        status,
        shippingAddress,
        items,
        createdAt,
      ];
}
