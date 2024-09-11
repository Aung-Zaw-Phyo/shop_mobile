import 'package:shop_mobile/features/cart/data/models/image_model.dart';
import 'package:shop_mobile/features/orders/domain/entities/order_item.dart';

class OrderItemModel extends OrderItemEntity {
  const OrderItemModel({
    required int id,
    required String name,
    required String description,
    required String color,
    required String size,
    required List<ImageModel> images,
    required int price,
    required int quantity,
  }) : super(
          id: id,
          name: name,
          description: description,
          color: color,
          size: size,
          images: images,
          price: price,
          quantity: quantity,
        );

  factory OrderItemModel.fromJson(Map<String, dynamic> json) => OrderItemModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        color: json['color'],
        size: json['size'],
        images: json['images']
            .map<ImageModel>(
              (dynamic i) => ImageModel.fromJson(i as Map<String, dynamic>),
            )
            .toList(),
        price: json['price'],
        quantity: json['quantity'],
      );
}
