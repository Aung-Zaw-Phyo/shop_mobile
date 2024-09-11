import 'package:shop_mobile/features/orders/data/models/order_item_model.dart';
import 'package:shop_mobile/features/orders/data/models/shipping_address_model.dart';
import 'package:shop_mobile/features/orders/domain/entities/order_details.dart';

class OrderDetailsModel extends OrderDetailsEntity {
  const OrderDetailsModel({
    required int id,
    required String orderNumber,
    required int totalAmount,
    required String status,
    required ShippingAddressModel shippingAddress,
    required List<OrderItemModel> items,
    required String createdAt,
  }) : super(
          id: id,
          orderNumber: orderNumber,
          totalAmount: totalAmount,
          status: status,
          shippingAddress: shippingAddress,
          items: items,
          createdAt: createdAt,
        );

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) =>
      OrderDetailsModel(
        id: json['id'],
        orderNumber: json['orderNumber'],
        totalAmount: json['totalAmount'],
        status: json['status'],
        shippingAddress: ShippingAddressModel.fromJson(json['shippingAddress']),
        items: json['items']
            .map<OrderItemModel>(
              (dynamic i) => OrderItemModel.fromJson(i as Map<String, dynamic>),
            )
            .toList(),
        createdAt: json['createdAt'],
      );
}
