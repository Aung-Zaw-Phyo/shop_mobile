import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_mobile/features/orders/presentation/bloc/orders/orders_bloc.dart';
import 'package:shop_mobile/features/orders/presentation/bloc/orders/orders_event.dart';
import 'package:shop_mobile/features/orders/presentation/bloc/orders/orders_state.dart';
import 'package:shop_mobile/features/orders/presentation/widgets/order.dart';
import 'package:shop_mobile/features/products/presentation/widgets/app_bar_cart.dart';

class OrdersScreen extends StatefulWidget {
  static const String routeName = '/orders';
  const OrdersScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _OrderScreenState();
  }
}

class _OrderScreenState extends State<OrdersScreen> {
  final controller = ScrollController();

  @override
  void initState() {
    // BlocProvider.of<OrdersBloc>(context).add(const GetOrders(1));

    final ordersBloc = BlocProvider.of<OrdersBloc>(context);
    ordersBloc.add(const GetOrders(1));

    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        final data = ordersBloc.state.ordersDataEntity;
        if (data != null && data.currentPage < data.totalPages) {
          ordersBloc.add(GetOrders(data.currentPage + 1));
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future refresh() async {
    BlocProvider.of<OrdersBloc>(context).add(const OrdersRefresh());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Orders'),
            AppBarCart(),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
          child: BlocBuilder<OrdersBloc, OrdersState>(
            builder: (context, state) {
              if (state is OrdersLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is OrdersFailed) {
                return Center(
                  child: Text(state.errors![0]),
                );
              }

              if (state is OrdersLoaded) {
                final data = state.ordersDataEntity!;
                final orders = data.orders;
                if (orders.isEmpty) {
                  return const Center(
                    child: Text(
                      'No order,  go shopping.',
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                }
                return ListView.builder(
                  controller: controller,
                  itemCount: orders.length + 1,
                  itemBuilder: (context, index) {
                    if (index < state.ordersDataEntity!.orders.length) {
                      return Order(order: orders[index]);
                    } else {
                      if (state.ordersDataEntity!.currentPage ==
                          state.ordersDataEntity!.totalPages) {
                        return const SizedBox();
                      }
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 32),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                  },
                );
              }

              return Container();
            },
          ),
        ),
      ),
    );
  }
}
