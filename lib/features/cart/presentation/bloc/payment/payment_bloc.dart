import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shop_mobile/features/cart/domain/usecases/create_payment.dart';
import 'package:shop_mobile/features/cart/presentation/bloc/payment/payment_event.dart';
import 'package:shop_mobile/features/cart/presentation/bloc/payment/payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final CreatePaymentUseCase _createPaymentUseCase;

  PaymentBloc(
    this._createPaymentUseCase,
  ) : super(const PaymentInitial()) {
    on<CreatePayment>(
      onCreatePayment,
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }

  void onCreatePayment(CreatePayment event, Emitter<PaymentState> emit) async {
    emit(const PaymentLoading());
    final result = await _createPaymentUseCase.execute(
      shippingAddress: event.shippingAddressEntity,
    );
    result.fold((failure) {
      emit(PaymentFailed(failure.messages));
    }, (result) {
      emit(PaymentLoaded(result));
    });
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
