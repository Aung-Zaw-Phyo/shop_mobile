import 'package:dio/dio.dart';
import 'package:shop_mobile/core/constants/constants.dart';
import 'package:shop_mobile/core/error/exception.dart';
import 'package:shop_mobile/features/products/data/models/category_model.dart';

abstract class CategoriesRemoteDataSource {
  Future<List<CategoryModel>> getCategories();
}

class CategoriesRemoteDataSourceImpl extends CategoriesRemoteDataSource {
  final Dio _dio;
  CategoriesRemoteDataSourceImpl(this._dio);

  @override
  Future<List<CategoryModel>> getCategories() async {
    final response = await _dio.get('${Constant.baseUrl}/categories?limit=0');

    if (response.statusCode == 200) {
      List<CategoryModel> categories = response.data['data']['items']
          .map<CategoryModel>(
              (dynamic i) => CategoryModel.fromJson(i as Map<String, dynamic>))
          .toList();

      return categories;
    } else {
      final messages = response.data['messages'] == null
          ? ['Something wrong!']
          : (response.data['messages'] as List<dynamic>).cast<String>();
      throw ServerException(messages);
    }
  }
}
