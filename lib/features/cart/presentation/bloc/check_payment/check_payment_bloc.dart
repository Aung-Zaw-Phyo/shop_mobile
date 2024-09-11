import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shop_mobile/features/cart/domain/usecases/check_payment.dart';
import 'package:shop_mobile/features/cart/presentation/bloc/check_payment/check_payment_event.dart';
import 'package:shop_mobile/features/cart/presentation/bloc/check_payment/check_payment_state.dart';

class CheckPaymentBloc extends Bloc<CheckPaymentEvent, CheckPaymentState> {
  final CheckPaymentUseCase _checkPaymentUseCase;

  CheckPaymentBloc(
    this._checkPaymentUseCase,
  ) : super(const CheckPaymentLoading()) {
    on<CheckPayment>(
      onCheckPayment,
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }

  void onCheckPayment(
    CheckPayment event,
    Emitter<CheckPaymentState> emit,
  ) async {
    emit(const CheckPaymentLoading());
    final result =
        await _checkPaymentUseCase.execute(sessionId: event.sessionId);
    result.fold((failure) {
      emit(CheckPaymentFailed(failure.messages));
    }, (result) {
      emit(CheckPaymentLoaded(result));
    });
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
