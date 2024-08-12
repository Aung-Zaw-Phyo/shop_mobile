import 'package:equatable/equatable.dart';
import 'package:shop_mobile/features/products/domain/entities/product.dart';

class ProductsState extends Equatable {
  final List<ProductEntity>? products;
  final List<String>? errors;

  const ProductsState({this.products, this.errors});

  @override
  List<Object?> get props => [products, errors];
}

class ProductsInitial extends ProductsState {
  const ProductsInitial();
}

class ProductsLoading extends ProductsState {
  const ProductsLoading();
}

class ProductsLoaded extends ProductsState {
  const ProductsLoaded(List<ProductEntity> data) : super(products: data);
}

class ProductsFailed extends ProductsState {
  const ProductsFailed(List<String> errors) : super(errors: errors);
}
