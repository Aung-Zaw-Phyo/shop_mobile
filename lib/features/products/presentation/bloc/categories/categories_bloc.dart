import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shop_mobile/features/products/domain/usecases/get_categories.dart';
import 'package:shop_mobile/features/products/presentation/bloc/categories/categories_event.dart';
import 'package:shop_mobile/features/products/presentation/bloc/categories/categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final GetCategoriesUseCase _getCategoriesUseCase;

  CategoriesBloc(this._getCategoriesUseCase)
      : super(const CategoriesLoading()) {
    on<GetCategories>(
      onGetCategories,
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }

  void onGetCategories(
      GetCategories event, Emitter<CategoriesState> emit) async {
    final result = await _getCategoriesUseCase.execute();
    result.fold((failure) {
      emit(CategoriesFailed(failure.messages));
    }, (result) {
      emit(CategoriesLoaded(result));
    });
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
