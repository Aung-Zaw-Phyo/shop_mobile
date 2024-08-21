import 'package:equatable/equatable.dart';
import 'package:shop_mobile/features/cart/domain/entities/product.dart';

class VariantEntity extends Equatable {
  final int id;
  final String color;
  final String size;
  final int stock;
  final ProductEntity product;

  const VariantEntity({
    required this.id,
    required this.color,
    required this.size,
    required this.stock,
    required this.product,
  });

  @override
  List<Object?> get props => [id, color, size, stock, product];
}
