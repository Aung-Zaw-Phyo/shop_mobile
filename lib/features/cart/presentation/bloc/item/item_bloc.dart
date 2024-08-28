import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shop_mobile/features/cart/domain/usecases/add_item.dart';
import 'package:shop_mobile/features/cart/domain/usecases/remove_item.dart';
import 'package:shop_mobile/features/cart/presentation/bloc/item/item_event.dart';
import 'package:shop_mobile/features/cart/presentation/bloc/item/item_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  final AddItemUseCase _addItemUseCase;
  final RemoveItemUseCase _removeItemUseCase;

  ItemBloc(
    this._addItemUseCase,
    this._removeItemUseCase,
  ) : super(const ItemLoading()) {
    on<AddItem>(
      onAddItem,
      transformer: debounce(const Duration(milliseconds: 500)),
    );
    on<RemoveItem>(
      onRemoveItem,
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }

  void onAddItem(AddItem event, Emitter<ItemState> emit) async {
    emit(const ItemLoading());
    final result = await _addItemUseCase.execute(
      quantity: event.quantity,
      variantId: event.variantId,
    );
    result.fold((failure) {
      emit(ItemFailed(failure.messages));
    }, (result) {
      emit(ItemLoaded(result));
    });
  }

  void onRemoveItem(RemoveItem event, Emitter<ItemState> emit) async {
    emit(const ItemLoading());
    final result = await _removeItemUseCase.execute(
      quantity: event.quantity,
      variantId: event.variantId,
    );
    result.fold((failure) {
      emit(ItemFailed(failure.messages));
    }, (result) {
      emit(ItemLoaded(result));
    });
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
