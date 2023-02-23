import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';

class ProductInfoScreen extends StatelessWidget {
  // final String title;
  // final double price;

  // const ProductInfoScreen(this.title, this.price, {super.key});
  static const routeName = '/product-info';
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments as String;
    final loadedProduct =
        Provider.of<Products>(context, listen: false).findById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text("title"),
      ),
    );
  }
}
