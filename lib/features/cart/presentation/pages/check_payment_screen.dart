import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_mobile/features/cart/presentation/bloc/check_payment/check_payment_bloc.dart';
import 'package:shop_mobile/features/cart/presentation/bloc/check_payment/check_payment_event.dart';
import 'package:shop_mobile/features/cart/presentation/bloc/check_payment/check_payment_state.dart';
import 'package:shop_mobile/features/orders/presentation/pages/order_details_screen.dart';
import 'package:shop_mobile/features/products/presentation/pages/products_screen.dart';

class CheckPaymentScreen extends StatefulWidget {
  static const String routeName = 'checkPayment';

  final String sessionId;
  const CheckPaymentScreen({super.key, required this.sessionId});

  @override
  State<StatefulWidget> createState() {
    return _CheckPaymentScreenState();
  }
}

// 4242424242424242
class _CheckPaymentScreenState extends State<CheckPaymentScreen> {
  @override
  void initState() {
    BlocProvider.of<CheckPaymentBloc>(context)
        .add(CheckPayment(widget.sessionId));
    super.initState();
  }

  void reload() {
    BlocProvider.of<CheckPaymentBloc>(context)
        .add(CheckPayment(widget.sessionId));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, ProductsScreen.routeName);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: BlocBuilder<CheckPaymentBloc, CheckPaymentState>(
            builder: (context, state) {
              if (state is CheckPaymentLoading) {
                return const CircularProgressIndicator();
              }

              if (state is CheckPaymentFailed) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Waiting for payment confirmation. Please standby ...',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: reload,
                      child: const Text('Reload'),
                    ),
                  ],
                );
              }

              if (state is CheckPaymentLoaded) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Thank you for purchasing!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          OrderDetailsScreen.routeName,
                          arguments: state.orderId,
                        );
                      },
                      child: const Text('View your order'),
                    ),
                  ],
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
