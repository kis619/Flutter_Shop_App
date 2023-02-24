import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders_provider.dart' show Orders;
import '../widgets/order_item.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context).orders;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your orders'),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, i) {
          return OrderItem(orders[i]);
        },
        itemCount: orders.length,
      ),
    );
  }
}
