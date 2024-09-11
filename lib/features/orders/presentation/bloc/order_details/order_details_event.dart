import 'package:equatable/equatable.dart';

class OrderDetailsEvent extends Equatable {
  const OrderDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetOrderDetails extends OrderDetailsEvent {
  final int orderId;
  const GetOrderDetails(this.orderId);

  @override
  List<Object> get props => [orderId];
}
