import 'package:equatable/equatable.dart';
import 'package:shop_mobile/features/orders/domain/entities/order_details.dart';

class OrderDetailsState extends Equatable {
  const OrderDetailsState();

  @override
  List<Object> get props => [];
}

class OrderDetailsLoading extends OrderDetailsState {
  const OrderDetailsLoading();
}

class OrderDetailsLoaded extends OrderDetailsState {
  final OrderDetailsEntity orderEntity;
  const OrderDetailsLoaded(this.orderEntity);

  @override
  List<Object> get props => [orderEntity];
}

class OrderDetailsFailed extends OrderDetailsState {
  final List<String> errors;
  const OrderDetailsFailed(this.errors);

  @override
  List<Object> get props => [errors];
}
