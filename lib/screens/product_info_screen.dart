import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';

class ProductInfoScreen extends StatelessWidget {
  const ProductInfoScreen({super.key});
  static const routeName = '/product-info';
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments as String;
    final loadedProduct =
        Provider.of<Products>(context, listen: false).findById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: 300,
            width: double.infinity,
            child: Hero(
              tag: loadedProduct.id,
              child: Image.network(
                loadedProduct.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '\$${loadedProduct.price}',
            style: const TextStyle(color: Colors.grey, fontSize: 20),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            child: Text(
              loadedProduct.description,
              textAlign: TextAlign.center,
              softWrap: true,
            ),
          )
        ]),
      ),
    );
  }
}
