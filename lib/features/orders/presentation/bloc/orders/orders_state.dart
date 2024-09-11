import 'package:equatable/equatable.dart';
import 'package:shop_mobile/features/orders/domain/entities/orders_data.dart';

class OrdersState extends Equatable {
  final OrdersDataEntity? ordersDataEntity;
  final List<String>? errors;

  const OrdersState({this.ordersDataEntity, this.errors});

  @override
  List<Object?> get props => [ordersDataEntity, errors];
}

class OrdersInitial extends OrdersState {
  const OrdersInitial();
}

class OrdersLoading extends OrdersState {
  const OrdersLoading();
}

class OrdersLoaded extends OrdersState {
  const OrdersLoaded(OrdersDataEntity data) : super(ordersDataEntity: data);
}

class OrdersFailed extends OrdersState {
  const OrdersFailed(List<String> errors) : super(errors: errors);
}
