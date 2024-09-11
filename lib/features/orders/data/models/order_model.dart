import 'package:shop_mobile/features/orders/data/models/shipping_address_model.dart';
import 'package:shop_mobile/features/orders/domain/entities/order.dart';

class OrderModel extends OrderEntity {
  const OrderModel({
    required int id,
    required String orderNumber,
    required int totalAmount,
    required String status,
    required ShippingAddressModel shippingAddress,
    required String createdAt,
  }) : super(
          id: id,
          orderNumber: orderNumber,
          totalAmount: totalAmount,
          status: status,
          shippingAddress: shippingAddress,
          createdAt: createdAt,
        );

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json['id'],
        orderNumber: json['orderNumber'],
        totalAmount: json['totalAmount'],
        status: json['status'],
        shippingAddress: ShippingAddressModel.fromJson(json['shippingAddress']),
        createdAt: json['createdAt'],
      );
}
