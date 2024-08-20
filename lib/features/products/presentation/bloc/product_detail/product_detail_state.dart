import 'package:equatable/equatable.dart';
import 'package:shop_mobile/features/products/domain/entities/product.dart';

class ProductDetailState extends Equatable {
  const ProductDetailState();

  @override
  List<Object> get props => [];
}

class ProductDetailLoading extends ProductDetailState {
  const ProductDetailLoading();
}

class ProductDetailLoaded extends ProductDetailState {
  final ProductEntity productEntity;
  const ProductDetailLoaded(this.productEntity);

  @override
  List<Object> get props => [productEntity];
}

class ProductDetailFailed extends ProductDetailState {
  final List<String> messages;
  const ProductDetailFailed(this.messages);

  @override
  List<Object> get props => [messages];
}
