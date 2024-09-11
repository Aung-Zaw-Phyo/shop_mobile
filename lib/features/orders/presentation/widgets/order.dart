import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_mobile/features/orders/domain/entities/order.dart';
import 'package:shop_mobile/features/orders/presentation/pages/order_details_screen.dart';

class Order extends StatelessWidget {
  final OrderEntity order;
  const Order({super.key, required this.order});

  String formattedDate(dateTimeStr) {
    DateTime dateTime = DateTime.parse(dateTimeStr);
    DateFormat formatter = DateFormat('MMMM d, yyyy');
    String formattedDate = formatter.format(dateTime);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color.fromARGB(130, 158, 158, 158)),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order #: ${order.orderNumber}',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Text(
                '\$${order.totalAmount.toString()}',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Text(
            formattedDate(order.createdAt),
            style: const TextStyle(
              color: Color.fromARGB(158, 0, 0, 0),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: order.status == 'Pending' ? Colors.red : Colors.blue,
                ),
                child: Text(
                  order.status,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(OrderDetailsScreen.routeName,
                      arguments: order.id);
                },
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
                child: const Text(
                  'View Details',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
