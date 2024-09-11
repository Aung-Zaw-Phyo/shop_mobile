import 'package:shop_mobile/features/orders/data/models/order_model.dart';
import 'package:shop_mobile/features/orders/domain/entities/orders_data.dart';

class OrdersDataModel extends OrdersDataEntity {
  const OrdersDataModel({
    required int currentPage,
    required int totalPages,
    required List<OrderModel> orders,
  }) : super(
          currentPage: currentPage,
          totalPages: totalPages,
          orders: orders,
        );
}
