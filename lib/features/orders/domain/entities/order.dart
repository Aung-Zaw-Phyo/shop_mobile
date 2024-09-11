import 'package:equatable/equatable.dart';
import 'package:shop_mobile/features/orders/domain/entities/shipping_address.dart';

class OrderEntity extends Equatable {
  final int id;
  final String orderNumber;
  final int totalAmount;
  final String status;
  final ShippingAddressEntity shippingAddress;
  final String createdAt;

  const OrderEntity({
    required this.id,
    required this.orderNumber,
    required this.totalAmount,
    required this.status,
    required this.shippingAddress,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        orderNumber,
        totalAmount,
        status,
        shippingAddress,
        createdAt,
      ];
}
