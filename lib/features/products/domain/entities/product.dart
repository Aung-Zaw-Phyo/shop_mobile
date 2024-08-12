import 'package:equatable/equatable.dart';
import 'package:shop_mobile/features/products/domain/entities/category.dart';
import 'package:shop_mobile/features/products/domain/entities/image.dart';
import 'package:shop_mobile/features/products/domain/entities/variant.dart';

class ProductEntity extends Equatable {
  final int id;
  final String name;
  final String description;
  final int price;
  final List<CategoryEntity> categories;
  final List<VariantEntity> variants;
  final List<ImageEntity> images;

  const ProductEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.categories,
    required this.variants,
    required this.images,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        price,
        categories,
        variants,
        images,
      ];
}
