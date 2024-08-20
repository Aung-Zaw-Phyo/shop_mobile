import 'package:dio/dio.dart';
import 'package:shop_mobile/core/constants/constants.dart';
import 'package:shop_mobile/core/error/exception.dart';
import 'package:shop_mobile/features/products/data/models/product_model.dart';
import 'package:shop_mobile/features/products/data/models/products_data_model.dart';

abstract class ProductsRemoteDataSource {
  Future<ProductsDataModel> getProducts(int page);
  Future<ProductModel> getProductDetail(int productId);
}

class ProductsRemoteDataSourceImpl extends ProductsRemoteDataSource {
  final Dio _dio;
  ProductsRemoteDataSourceImpl(this._dio);

  @override
  Future<ProductsDataModel> getProducts(int page) async {
    final response = await _dio.get(
        '${Constant.baseUrl}/products?page=$page&limit=${Constant.paginateItemsLimit}');

    if (response.statusCode == 200) {
      List<ProductModel> products = response.data['data']['items']
          .map<ProductModel>(
              (dynamic i) => ProductModel.fromJson(i as Map<String, dynamic>))
          .toList();
      final productsData = ProductsDataModel(
        currentPage: response.data['data']['meta']['currentPage'],
        totalPages: response.data['data']['meta']['totalPages'],
        products: products,
      );
      return productsData;
    } else {
      throw ServerException(response.data['messages'] ?? ['Something wrong!']);
    }
  }

  @override
  Future<ProductModel> getProductDetail(int productId) async {
    final response = await _dio.get('${Constant.baseUrl}/products/$productId');

    if (response.statusCode == 200) {
      final product = ProductModel.fromJson(response.data['data']);
      return product;
    } else {
      throw ServerException(response.data['messages'] ?? ['Something wrong!']);
    }
  }
}
