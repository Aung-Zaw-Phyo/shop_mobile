import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shop_mobile/features/orders/presentation/bloc/order_details/order_details_bloc.dart';
import 'package:shop_mobile/features/orders/presentation/bloc/order_details/order_details_event.dart';
import 'package:shop_mobile/features/orders/presentation/bloc/order_details/order_details_state.dart';
import 'package:shop_mobile/features/orders/presentation/pages/orders_screen.dart';
import 'package:shop_mobile/features/orders/presentation/widgets/order_items.dart';
import 'package:shop_mobile/features/orders/presentation/widgets/shipping_address.dart';
import 'package:shop_mobile/features/products/presentation/widgets/app_bar_cart.dart';

class OrderDetailsScreen extends StatefulWidget {
  static const String routeName = 'orderDetails';
  final int orderId;
  const OrderDetailsScreen({super.key, required this.orderId});
  @override
  State<StatefulWidget> createState() {
    return _OrderDetailsScreenState();
  }
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  void initState() {
    BlocProvider.of<OrderDetailsBloc>(context)
        .add(GetOrderDetails(widget.orderId));
    super.initState();
  }

  String formattedDate(dateTimeStr) {
    DateTime dateTime = DateTime.parse(dateTimeStr);
    DateFormat formatter = DateFormat('MMMM d, yyyy');
    String formattedDate = formatter.format(dateTime);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, OrdersScreen.routeName);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          foregroundColor: Colors.white,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Order Details'),
              AppBarCart(),
            ],
          ),
        ),
        body: BlocBuilder<OrderDetailsBloc, OrderDetailsState>(
          builder: (context, state) {
            if (state is OrderDetailsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is OrderDetailsFailed) {
              return Center(
                child: Text(state.errors[0]),
              );
            }

            if (state is OrderDetailsLoaded) {
              final order = state.orderEntity;
              return SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Order #: ${order.orderNumber}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            formattedDate(order.createdAt),
                            style: const TextStyle(
                              color: Color.fromARGB(188, 0, 0, 0),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Status',
                            style: TextStyle(fontSize: 16),
                          ),
                          const Spacer(),
                          Text(
                            order.status,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: order.status == 'Pending'
                                  ? Colors.red
                                  : Colors.blue,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Total Amount',
                            style: TextStyle(fontSize: 16),
                          ),
                          const Spacer(),
                          Text(
                            '\$${order.totalAmount}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Items',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      OrderItems(items: order.items),
                      const SizedBox(height: 10),
                      const Text(
                        'Shipping Address',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      ShippingAddress(shippingAddress: order.shippingAddress),
                    ],
                  ),
                ),
              );
            }

            return Container();
          },
        ),
      ),
    );
  }
}
