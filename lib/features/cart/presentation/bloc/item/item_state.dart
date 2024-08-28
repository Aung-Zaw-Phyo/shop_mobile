import 'package:equatable/equatable.dart';
import 'package:shop_mobile/features/cart/domain/entities/cart.dart';

class ItemState extends Equatable {
  const ItemState();

  @override
  List<Object?> get props => [];
}

class ItemLoading extends ItemState {
  const ItemLoading();
}

class ItemLoaded extends ItemState {
  final CartEntity cartEntity;
  const ItemLoaded(this.cartEntity);

  @override
  List<Object> get props => [cartEntity];
}

class ItemFailed extends ItemState {
  final List<String> errors;
  const ItemFailed(this.errors);

  @override
  List<Object> get props => [errors];
}
