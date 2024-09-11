import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shop_mobile/features/orders/domain/usecases/get_orders.dart';
import 'package:shop_mobile/features/orders/presentation/bloc/orders/orders_event.dart';
import 'package:shop_mobile/features/orders/presentation/bloc/orders/orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final GetOrdersUseCase _getOrdersUseCase;

  OrdersBloc(this._getOrdersUseCase) : super(const OrdersLoading()) {
    on<GetOrders>(
      onGetOrders,
      transformer: debounce(const Duration(milliseconds: 500)),
    );
    on<OrdersRefresh>(
      onOrdersRefresh,
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }

  void onGetOrders(GetOrders event, Emitter<OrdersState> emit) async {
    final result = await _getOrdersUseCase.execute(event.page);
    result.fold((failure) {
      emit(OrdersFailed(failure.messages));
    }, (result) {
      final data = state.ordersDataEntity;
      if (data != null) {
        result.orders.insertAll(0, data.orders);
      }
      emit(OrdersLoaded(result));
    });
  }

  void onOrdersRefresh(OrdersRefresh event, Emitter<OrdersState> emit) async {
    emit(const OrdersLoading());
    final result = await _getOrdersUseCase.execute(1);
    result.fold((failure) {
      emit(OrdersFailed(failure.messages));
    }, (result) {
      emit(OrdersLoaded(result));
    });
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
