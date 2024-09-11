import 'package:equatable/equatable.dart';
import 'package:shop_mobile/features/cart/domain/entities/image.dart';

class OrderItemEntity extends Equatable {
  final int id;
  final String name;
  final String description;
  final String color;
  final String size;
  final List<ImageEntity> images;
  final int price;
  final int quantity;

  const OrderItemEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.color,
    required this.size,
    required this.images,
    required this.price,
    required this.quantity,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        color,
        size,
        images,
        price,
        quantity,
      ];
}
