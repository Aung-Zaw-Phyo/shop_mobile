import 'package:equatable/equatable.dart';

abstract class OrdersEvent extends Equatable {
  const OrdersEvent();

  @override
  List<Object> get props => [];
}

class GetOrders extends OrdersEvent {
  final int page;
  const GetOrders(this.page);

  @override
  List<Object> get props => [page];
}

class OrdersRefresh extends OrdersEvent {
  const OrdersRefresh();
}
