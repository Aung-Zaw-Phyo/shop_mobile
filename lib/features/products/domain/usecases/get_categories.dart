import 'package:dartz/dartz.dart';
import 'package:shop_mobile/core/error/failure.dart';
import 'package:shop_mobile/features/products/domain/entities/category.dart';
import 'package:shop_mobile/features/products/domain/repositories/categories.repository.dart';

class GetCategoriesUseCase {
  final CategoriesRepository _categoriesRepository;
  const GetCategoriesUseCase(this._categoriesRepository);

  Future<Either<Failure, List<CategoryEntity>>> execute() {
    return _categoriesRepository.getCategories();
  }
}
