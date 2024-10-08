import 'package:equatable/equatable.dart';
import 'package:shop_mobile/features/products/domain/entities/category.dart';

class CategoriesState extends Equatable {
  const CategoriesState();

  @override
  List<Object?> get props => [];
}

class CategoriesLoading extends CategoriesState {
  const CategoriesLoading();
}

class CategoriesLoaded extends CategoriesState {
  final List<CategoryEntity> categories;
  const CategoriesLoaded(this.categories);

  @override
  List<Object?> get props => [categories];
}

class CategoriesFailed extends CategoriesState {
  final List<String> errors;
  const CategoriesFailed(this.errors);

  @override
  List<Object?> get props => [errors];
}
