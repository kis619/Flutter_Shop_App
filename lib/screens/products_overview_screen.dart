import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/widgets/app_drawer.dart';
// import 'package:shop_app/providers/cart_provider.dart';

import '../providers/cart_provider.dart';
import '../providers/products_provider.dart';
import '../widgets/products_grid.dart';
import '../widgets/badge.dart';

enum FilterOptions {
  favourites,
  all,
}

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({super.key});

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showFavouritesOnly = false;
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Future.delayed(Duration.zero).then((_) => {
    //   Provider.of<Products>(context).fetchAndSetProducts()
    // }); hacky way to do it
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context).fetchAndSetProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SHOP'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.favourites) {
                  _showFavouritesOnly = true;
                } else if (selectedValue == FilterOptions.all) {
                  _showFavouritesOnly = false;
                }
              });
            },
            itemBuilder: (_) => [
              const PopupMenuItem(
                  value: FilterOptions.favourites,
                  child: Text('Only favourites')),
              const PopupMenuItem(
                  value: FilterOptions.all, child: Text('Show all')),
            ],
            icon: const Icon(Icons.more_vert),
          ),
          Consumer<Cart>(
            builder: (_, cart, child) => BadgeK(
              color: Colors.amber,
              value: cart.countUniqueItems.toString(),
              child: child as Widget,
            ),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
              icon: const Icon(Icons.shopping_cart),
            ),
          )
        ],
      ),
      drawer: const AppDrawer(),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ProductsGrid(_showFavouritesOnly),
    );
  }
}
