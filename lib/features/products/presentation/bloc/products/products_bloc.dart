import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shop_mobile/features/products/domain/usecases/get_products.dart';
import 'package:shop_mobile/features/products/presentation/bloc/products/products_event.dart';
import 'package:shop_mobile/features/products/presentation/bloc/products/products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final GetProductsUseCase _getProductsUseCase;

  ProductsBloc(this._getProductsUseCase) : super(const ProductsLoading()) {
    on<GetProducts>(
      onGetProducts,
      transformer: debounce(const Duration(milliseconds: 500)),
    );
    on<ProductsRefresh>(
      onProductsRefresh,
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }

  void onGetProducts(GetProducts event, Emitter<ProductsState> emit) async {
    final result = await _getProductsUseCase.execute(
      page: event.page,
      categoryId: event.categoryId,
      search: event.search,
    );
    result.fold((failure) {
      emit(ProductsFailed(failure.messages));
    }, (result) {
      final data = state.productsDataEntity;
      if (data != null) {
        result.products.insertAll(0, data.products);
      }
      emit(ProductsLoaded(result));
    });
  }

  void onProductsRefresh(
      ProductsRefresh event, Emitter<ProductsState> emit) async {
    emit(const ProductsLoading());
    final result = await _getProductsUseCase.execute(
      page: 1,
      categoryId: event.categoryId,
      search: event.search,
    );
    result.fold((failure) {
      emit(ProductsFailed(failure.messages));
    }, (result) {
      emit(ProductsLoaded(result));
    });
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
