import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/app_drawer.dart';

import '../providers/orders_provider.dart' show Orders;
import '../widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';
  const OrdersScreen({super.key});
  @override
  Widget build(BuildContext context) {
    // final orders = Provider.of<Orders>(context).orders;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your orders'),
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
        builder: (
          ctx,
          dataSnapshot,
        ) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (dataSnapshot.error != null) {
            return const Center(
              child: Text('An error occured!'),
            );
          } else {
            return Consumer<Orders>(
                builder: (ctx, orderData, child) => ListView.builder(
                      itemBuilder: (ctx, i) {
                        return OrderItem(orderData.orders[i]);
                      },
                      itemCount: orderData.orders.length,
                    ));
          }
        },
      ),
    );
  }
}
