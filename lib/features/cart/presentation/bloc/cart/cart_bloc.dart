import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shop_mobile/features/cart/domain/usecases/get_cart.dart';
import 'package:shop_mobile/features/cart/presentation/bloc/cart/cart_event.dart';
import 'package:shop_mobile/features/cart/presentation/bloc/cart/cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetCartUseCase _getCartUseGetCartUseCase;

  CartBloc(this._getCartUseGetCartUseCase) : super(const CartLoading()) {
    on<GetCart>(
      onGetCart,
      transformer: debounce(const Duration(milliseconds: 500)),
    );
    on<CartItemChange>(
      onCartItemChange,
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }

  void onGetCart(GetCart event, Emitter<CartState> emit) async {
    final result = await _getCartUseGetCartUseCase.execute();
    result.fold((failure) {
      emit(CartFailed(failure.messages));
    }, (result) {
      emit(CartLoaded(result));
    });
  }

  void onCartItemChange(CartItemChange event, Emitter<CartState> emit) {
    emit(CartLoaded(event.cartEntity));
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
