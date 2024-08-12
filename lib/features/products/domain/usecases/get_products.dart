import 'package:dartz/dartz.dart';
import 'package:shop_mobile/core/error/failure.dart';
import 'package:shop_mobile/features/products/domain/entities/product.dart';
import 'package:shop_mobile/features/products/domain/repositories/products_repository.dart';

class GetProductsUseCase {
  final ProductsRepository _productsRepository;
  const GetProductsUseCase(this._productsRepository);

  Future<Either<Failure, List<ProductEntity>>> execute() {
    return _productsRepository.getProducts();
  }
}
