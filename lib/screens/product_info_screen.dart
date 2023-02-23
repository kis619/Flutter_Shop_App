import 'package:flutter/material.dart';

class ProductInfoScreen extends StatelessWidget {
  // final String title;
  // final double price;

  // const ProductInfoScreen(this.title, this.price, {super.key});
  static const routeName = '/product-info';
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text("title"),
      ),
    );
  }
}
