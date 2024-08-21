import 'package:get_it/get_it.dart';
import 'package:shop_mobile/core/dio_client.dart';
import 'package:shop_mobile/features/cart/data/data_sources/remote_data_source.dart';
import 'package:shop_mobile/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:shop_mobile/features/cart/domain/repositories/cart_repository.dart';
import 'package:shop_mobile/features/products/data/data_sources/remote_data_source.dart';
import 'package:shop_mobile/features/products/data/repositories/products_repository_impl.dart';
import 'package:shop_mobile/features/products/domain/repositories/products_repository.dart';
import 'package:shop_mobile/features/cart/domain/usecases/get_cart.dart';
import 'package:shop_mobile/features/products/domain/usecases/get_product_detail.dart';
import 'package:shop_mobile/features/products/domain/usecases/get_products.dart';
import 'package:shop_mobile/features/cart/presentation/bloc/cart/cart_bloc.dart';
import 'package:shop_mobile/features/products/presentation/bloc/product_detail/product_detail_bloc.dart';
import 'package:shop_mobile/features/products/presentation/bloc/products/products_bloc.dart';

final locator = GetIt.instance;

void setupLocator() async {
  // bloc
  locator.registerFactory<ProductsBloc>(
    () => ProductsBloc(locator()),
  );
  locator.registerFactory<ProductDetailBloc>(
    () => ProductDetailBloc(locator()),
  );
  locator.registerFactory<CartBloc>(
    () => CartBloc(locator()),
  );

  // usecase
  locator.registerLazySingleton<GetProductsUseCase>(
      () => GetProductsUseCase(locator()));
  locator.registerLazySingleton<GetProductDetailUseCase>(
      () => GetProductDetailUseCase(locator()));
  locator
      .registerLazySingleton<GetCartUseCase>(() => GetCartUseCase(locator()));

  // repository
  locator.registerLazySingleton<ProductsRepository>(
      () => ProductsRepositoryImpl(locator()));
  locator.registerLazySingleton<CartRepository>(
      () => CartRepositoryImpl(locator()));

  // datasource
  locator.registerLazySingleton<ProductsRemoteDataSource>(
      () => ProductsRemoteDataSourceImpl(locator()));
  locator.registerLazySingleton<CartRemoteDataSource>(
      () => CartRemoteDataSourceImpl(locator()));

  // external

  locator.registerLazySingleton(() => dio_client);
}
