import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:shop_mobile/core/error/exception.dart';
import 'package:shop_mobile/core/error/failure.dart';
import 'package:shop_mobile/features/products/data/data_sources/remote_data_source.dart';
import 'package:shop_mobile/features/products/domain/entities/products_data.dart';
import 'package:shop_mobile/features/products/domain/repositories/products_repository.dart';

class ProductsRepositoryImpl extends ProductsRepository {
  final ProductsRemoteDataSource _productsRemoteDataSource;
  ProductsRepositoryImpl(this._productsRemoteDataSource);

  @override
  Future<Either<Failure, ProductsDataEntity>> getProducts(int page) async {
    try {
      final result = await _productsRemoteDataSource.getProducts(page);
      return right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.messages));
    } on SocketException {
      return const Left(
          ConnectionFailure(['Failed to connect to the internet']));
    }
  }
}
