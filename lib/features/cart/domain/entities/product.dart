import 'package:equatable/equatable.dart';
import 'package:shop_mobile/features/cart/domain/entities/image.dart';

class ProductEntity extends Equatable {
  final int id;
  final String name;
  final String description;
  final int price;
  final List<ImageEntity> images;

  const ProductEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.images,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        price,
        images,
      ];
}
