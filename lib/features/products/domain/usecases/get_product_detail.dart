import 'package:dartz/dartz.dart';
import 'package:shop_mobile/core/error/failure.dart';
import 'package:shop_mobile/features/products/domain/entities/product.dart';
import 'package:shop_mobile/features/products/domain/repositories/products_repository.dart';

class GetProductDetailUseCase {
  final ProductsRepository _productsRepository;
  const GetProductDetailUseCase(this._productsRepository);

  Future<Either<Failure, ProductEntity>> execute(int productId) {
    return _productsRepository.getProductDetail(productId);
  }
}
