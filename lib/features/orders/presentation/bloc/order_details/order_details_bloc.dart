import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_mobile/features/orders/domain/usecases/get_order_details.dart';
import 'package:shop_mobile/features/orders/presentation/bloc/order_details/order_details_event.dart';
import 'package:shop_mobile/features/orders/presentation/bloc/order_details/order_details_state.dart';

class OrderDetailsBloc extends Bloc<OrderDetailsEvent, OrderDetailsState> {
  final GetOrderDetailsUseCase _getOrderDetailsUseCase;

  OrderDetailsBloc(this._getOrderDetailsUseCase)
      : super(const OrderDetailsLoading()) {
    on<GetOrderDetails>(
      onGetOrderDetails,
    );
  }

  onGetOrderDetails(
      GetOrderDetails event, Emitter<OrderDetailsState> emit) async {
    emit(const OrderDetailsLoading());

    final result = await _getOrderDetailsUseCase.execute(event.orderId);

    result.fold((failure) {
      emit(OrderDetailsFailed(failure.messages));
    }, (result) {
      emit(OrderDetailsLoaded(result));
    });
  }
}
