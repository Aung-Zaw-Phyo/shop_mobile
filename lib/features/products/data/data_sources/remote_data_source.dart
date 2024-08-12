import 'package:dio/dio.dart';
import 'package:shop_mobile/core/constants/constants.dart';
import 'package:shop_mobile/core/error/exception.dart';
import 'package:shop_mobile/features/products/data/models/product_model.dart';

abstract class ProductsRemoteDataSource {
  Future<List<ProductModel>> getProducts();
}

class ProductsRemoteDataSourceImpl extends ProductsRemoteDataSource {
  final Dio _dio;
  ProductsRemoteDataSourceImpl(this._dio);

  @override
  Future<List<ProductModel>> getProducts() async {
    final response = await _dio.get('${Urls.baseUrl}/products');

    if (response.statusCode == 200) {
      List<ProductModel> products = response.data['data']['items']
          .map<ProductModel>(
              (dynamic i) => ProductModel.fromJson(i as Map<String, dynamic>))
          .toList();
      print('*******************************************');
      print(products);
      return products;
    } else {
      throw ServerException(response.data['messages'] ?? ['Something wrong!']);
    }
  }
}
