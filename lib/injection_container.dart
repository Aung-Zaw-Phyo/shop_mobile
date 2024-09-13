import 'package:get_it/get_it.dart';
import 'package:shop_mobile/core/dio_client.dart';
import 'package:shop_mobile/features/auth/data/data_sources/remote_data_source.dart';
import 'package:shop_mobile/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:shop_mobile/features/auth/domain/repositories/auth_repositor.dart';
import 'package:shop_mobile/features/auth/domain/usecases/login.dart';
import 'package:shop_mobile/features/auth/domain/usecases/register.dart';
import 'package:shop_mobile/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:shop_mobile/features/cart/data/data_sources/remote_data_source.dart';
import 'package:shop_mobile/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:shop_mobile/features/cart/domain/repositories/cart_repository.dart';
import 'package:shop_mobile/features/cart/domain/usecases/add_item.dart';
import 'package:shop_mobile/features/cart/domain/usecases/check_payment.dart';
import 'package:shop_mobile/features/cart/domain/usecases/create_payment.dart';
import 'package:shop_mobile/features/cart/domain/usecases/remove_item.dart';
import 'package:shop_mobile/features/cart/presentation/bloc/check_payment/check_payment_bloc.dart';
import 'package:shop_mobile/features/cart/presentation/bloc/item/item_bloc.dart';
import 'package:shop_mobile/features/cart/presentation/bloc/payment/payment_bloc.dart';
import 'package:shop_mobile/features/orders/data/data_sources/remote_data_source.dart';
import 'package:shop_mobile/features/orders/data/repositories/orders_repository_impl.dart';
import 'package:shop_mobile/features/orders/domain/repositories/orders_repository.dart';
import 'package:shop_mobile/features/orders/domain/usecases/get_order_details.dart';
import 'package:shop_mobile/features/orders/domain/usecases/get_orders.dart';
import 'package:shop_mobile/features/orders/presentation/bloc/order_details/order_details_bloc.dart';
import 'package:shop_mobile/features/orders/presentation/bloc/orders/orders_bloc.dart';
import 'package:shop_mobile/features/products/data/data_sources/remote_data_source.dart';
import 'package:shop_mobile/features/products/data/repositories/products_repository_impl.dart';
import 'package:shop_mobile/features/products/domain/repositories/products_repository.dart';
import 'package:shop_mobile/features/cart/domain/usecases/get_cart.dart';
import 'package:shop_mobile/features/products/domain/usecases/get_product_detail.dart';
import 'package:shop_mobile/features/products/domain/usecases/get_products.dart';
import 'package:shop_mobile/features/cart/presentation/bloc/cart/cart_bloc.dart';
import 'package:shop_mobile/features/products/presentation/bloc/product_detail/product_detail_bloc.dart';
import 'package:shop_mobile/features/products/presentation/bloc/products/products_bloc.dart';
import 'package:shop_mobile/features/profile/data/data_sources/remote_data_source.dart';
import 'package:shop_mobile/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:shop_mobile/features/profile/domain/repositories/profile_repository.dart';
import 'package:shop_mobile/features/profile/domain/usecases/get_profile.dart';
import 'package:shop_mobile/features/profile/domain/usecases/update_profile.dart';
import 'package:shop_mobile/features/profile/presentation/bloc/profile/profile_bloc.dart';
import 'package:shop_mobile/features/profile/presentation/bloc/update_profile/update_profile_bloc.dart';

final locator = GetIt.instance;

void setupLocator() async {
  // bloc
  locator.registerFactory<ProductsBloc>(
    () => ProductsBloc(locator()),
  );
  locator.registerFactory<ProductDetailBloc>(
    () => ProductDetailBloc(locator()),
  );
  locator.registerFactory<OrdersBloc>(
    () => OrdersBloc(locator()),
  );
  locator.registerFactory<OrderDetailsBloc>(
    () => OrderDetailsBloc(locator()),
  );
  locator.registerFactory<CartBloc>(
    () => CartBloc(locator()),
  );
  locator.registerFactory<ItemBloc>(
    () => ItemBloc(locator(), locator()),
  );
  locator.registerFactory<AuthBloc>(
    () => AuthBloc(locator(), locator()),
  );
  locator.registerFactory<ProfileBloc>(
    () => ProfileBloc(locator()),
  );
  locator.registerFactory<UpdateProfileBloc>(
    () => UpdateProfileBloc(locator()),
  );
  locator.registerFactory<PaymentBloc>(
    () => PaymentBloc(locator()),
  );
  locator.registerFactory<CheckPaymentBloc>(
    () => CheckPaymentBloc(locator()),
  );

  // usecase
  locator.registerLazySingleton<GetProductsUseCase>(
      () => GetProductsUseCase(locator()));
  locator.registerLazySingleton<GetProductDetailUseCase>(
      () => GetProductDetailUseCase(locator()));
  locator.registerLazySingleton<GetOrdersUseCase>(
      () => GetOrdersUseCase(locator()));
  locator.registerLazySingleton<GetOrderDetailsUseCase>(
      () => GetOrderDetailsUseCase(locator()));
  locator
      .registerLazySingleton<GetCartUseCase>(() => GetCartUseCase(locator()));
  locator
      .registerLazySingleton<AddItemUseCase>(() => AddItemUseCase(locator()));
  locator.registerLazySingleton<RemoveItemUseCase>(
      () => RemoveItemUseCase(locator()));
  locator.registerLazySingleton<LoginUseCase>(() => LoginUseCase(locator()));
  locator
      .registerLazySingleton<RegisterUseCase>(() => RegisterUseCase(locator()));
  locator.registerLazySingleton<GetProfileUseCase>(
      () => GetProfileUseCase(locator()));
  locator.registerLazySingleton<UpdateProfileUseCase>(
      () => UpdateProfileUseCase(locator()));
  locator.registerLazySingleton<CreatePaymentUseCase>(
      () => CreatePaymentUseCase(locator()));
  locator.registerLazySingleton<CheckPaymentUseCase>(
      () => CheckPaymentUseCase(locator()));

  // repository
  locator.registerLazySingleton<ProductsRepository>(
      () => ProductsRepositoryImpl(locator()));
  locator.registerLazySingleton<OrdersRepository>(
      () => OrdersRepositoryImpl(locator()));
  locator.registerLazySingleton<CartRepository>(
      () => CartRepositoryImpl(locator()));
  locator.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(locator()));
  locator.registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(locator()));

  // datasource
  locator.registerLazySingleton<ProductsRemoteDataSource>(
      () => ProductsRemoteDataSourceImpl(locator()));
  locator.registerLazySingleton<OrdersRemoteDataSource>(
      () => OrdersRemoteDataSourceImpl(locator()));
  locator.registerLazySingleton<CartRemoteDataSource>(
      () => CartRemoteDataSourceImpl(locator()));
  locator.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(locator()));
  locator.registerLazySingleton<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSourceImpl(locator()));

  // external

  locator.registerLazySingleton(() => dio_client);
}
