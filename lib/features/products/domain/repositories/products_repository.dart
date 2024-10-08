import 'package:dartz/dartz.dart';
import 'package:shop_mobile/core/error/failure.dart';
import 'package:shop_mobile/features/products/domain/entities/product.dart';
import 'package:shop_mobile/features/products/domain/entities/products_data.dart';

abstract class ProductsRepository {
  Future<Either<Failure, ProductsDataEntity>> getProducts({
    required int page,
    int? categoryId,
    String? search,
  });
  Future<Either<Failure, ProductEntity>> getProductDetail(int productId);
}
