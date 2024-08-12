import 'package:shop_mobile/features/products/data/models/product_model.dart';
import 'package:shop_mobile/features/products/domain/entities/products_data.dart';

class ProductsDataModel extends ProductsDataEntity {
  const ProductsDataModel({
    required int currentPage,
    required int totalPages,
    required List<ProductModel> products,
  }) : super(
          currentPage: currentPage,
          totalPages: totalPages,
          products: products,
        );
}
