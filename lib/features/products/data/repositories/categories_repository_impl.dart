import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:shop_mobile/core/error/exception.dart';
import 'package:shop_mobile/core/error/failure.dart';
import 'package:shop_mobile/features/products/data/data_sources/categories_remote_data_source.dart';
import 'package:shop_mobile/features/products/domain/entities/category.dart';
import 'package:shop_mobile/features/products/domain/repositories/categories.repository.dart';

class CategoriesRepositoryImpl extends CategoriesRepository {
  final CategoriesRemoteDataSource _categoriesRemoteDataSource;
  CategoriesRepositoryImpl(this._categoriesRemoteDataSource);

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {
    try {
      final result = await _categoriesRemoteDataSource.getCategories();
      return right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.messages));
    } on SocketException {
      return const Left(
          ConnectionFailure(['Failed to connect to the internet']));
    }
  }
}
