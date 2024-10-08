import 'package:dartz/dartz.dart';
import 'package:shop_mobile/core/error/failure.dart';
import 'package:shop_mobile/features/products/domain/entities/products_data.dart';
import 'package:shop_mobile/features/products/domain/repositories/products_repository.dart';

class GetProductsUseCase {
  final ProductsRepository _productsRepository;
  const GetProductsUseCase(this._productsRepository);

  Future<Either<Failure, ProductsDataEntity>> execute({
    required int page,
    int? categoryId,
    String? search,
  }) {
    return _productsRepository.getProducts(
      page: page,
      categoryId: categoryId,
      search: search,
    );
  }
}
