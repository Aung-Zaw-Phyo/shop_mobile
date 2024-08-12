import 'package:dartz/dartz.dart';
import 'package:shop_mobile/core/error/failure.dart';
import 'package:shop_mobile/features/products/domain/entities/product.dart';

abstract class ProductsRepository {
  Future<Either<Failure, List<ProductEntity>>> getProducts();
}
