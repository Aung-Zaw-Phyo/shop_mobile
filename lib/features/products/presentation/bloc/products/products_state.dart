import 'package:equatable/equatable.dart';
import 'package:shop_mobile/features/products/domain/entities/products_data.dart';

class ProductsState extends Equatable {
  final ProductsDataEntity? productsDataEntity;
  final List<String>? errors;

  const ProductsState({this.productsDataEntity, this.errors});

  @override
  List<Object?> get props => [productsDataEntity, errors];
}

class ProductsInitial extends ProductsState {
  const ProductsInitial();
}

class ProductsLoading extends ProductsState {
  const ProductsLoading();
}

class ProductsLoaded extends ProductsState {
  const ProductsLoaded(ProductsDataEntity data)
      : super(productsDataEntity: data);
}

class ProductsFailed extends ProductsState {
  const ProductsFailed(List<String> errors) : super(errors: errors);
}
