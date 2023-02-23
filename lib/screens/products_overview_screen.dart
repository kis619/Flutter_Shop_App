import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import '../widgets/products_grid.dart';

enum FilterOptions {
  favourites,
  all,
}

class ProductsOverviewScreen extends StatelessWidget {
  ProductsOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('SHOP'),
        actions: [
          PopupMenuButton(
            onSelected: (selectedValue) {
              if (selectedValue == FilterOptions.favourites) {
                products.showFavouritesOnly();
              } else if (selectedValue == FilterOptions.all) {
                products.showAll();
              }
            },
            itemBuilder: (_) => [
              const PopupMenuItem(
                  value: FilterOptions.favourites,
                  child: Text('Only favourites')),
              const PopupMenuItem(
                  value: FilterOptions.all, child: Text('Show all')),
            ],
            icon: const Icon(Icons.more_vert),
          )
        ],
      ),
      body: ProductsGrid(),
    );
  }
}
