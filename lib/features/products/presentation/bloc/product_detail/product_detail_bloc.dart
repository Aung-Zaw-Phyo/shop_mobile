import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_mobile/features/products/domain/usecases/get_product_detail.dart';
import 'package:shop_mobile/features/products/presentation/bloc/product_detail/product_detail_event.dart';
import 'package:shop_mobile/features/products/presentation/bloc/product_detail/product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final GetProductDetailUseCase _getProductDetailUseCase;

  ProductDetailBloc(this._getProductDetailUseCase)
      : super(const ProductDetailLoading()) {
    on<GetProductDetail>(onGetProductDetail);
  }

  onGetProductDetail(
      GetProductDetail event, Emitter<ProductDetailState> emit) async {
    emit(const ProductDetailLoading());

    final result = await _getProductDetailUseCase.execute(event.productId);

    result.fold((failure) {
      emit(ProductDetailFailed(failure.messages));
    }, (result) {
      emit(ProductDetailLoaded(result));
    });
  }
}
