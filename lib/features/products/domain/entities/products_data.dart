import 'package:equatable/equatable.dart';
import 'package:shop_mobile/features/products/domain/entities/product.dart';

class ProductsDataEntity extends Equatable {
  final int currentPage;
  final int totalPages;
  final List<ProductEntity> products;

  const ProductsDataEntity({
    required this.currentPage,
    required this.totalPages,
    required this.products,
  });

  @override
  List<Object> get props => [currentPage, totalPages, products];
}
