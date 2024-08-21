import 'package:equatable/equatable.dart';
import 'package:shop_mobile/features/cart/domain/entities/cart.dart';

class CartState extends Equatable {
  final CartEntity? cartEntity;
  final List<String>? errors;

  const CartState({this.cartEntity, this.errors});

  @override
  List<Object?> get props => [cartEntity, errors];
}

class CartInitial extends CartState {
  const CartInitial();
}

class CartLoading extends CartState {
  const CartLoading();
}

class CartLoaded extends CartState {
  const CartLoaded(CartEntity data) : super(cartEntity: data);
}

class CartFailed extends CartState {
  const CartFailed(List<String> errors) : super(errors: errors);
}
