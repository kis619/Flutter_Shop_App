import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './product_provider.dart';

class Products with ChangeNotifier {
  // ignore: prefer_final_fields
  List<Product> _items = [];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favItems {
    return _items.where((element) => element.isFavourite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> fetchAndSetProducts() async {
    final url = Uri.parse(
        "https://learning-flutter-72888-default-rtdb.europe-west1.firebasedatabase.app/products.json");
    try {
      final response = await http.get(url);
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      data.forEach((prodId, prodData) {
        loadedProducts.add(Product(
          id: prodId,
          title: prodData['title'],
          description: prodData['description'],
          price: prodData['price'],
          imageUrl: prodData['imageUrl'],
          isFavourite: prodData['isFavourite'],
        ));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addProduct(Product product) async {
    final url = Uri.parse(
        "https://learning-flutter-72888-default-rtdb.europe-west1.firebasedatabase.app/products.json");
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'isFavourite': product.isFavourite,
        }),
      );
      final newProduct = Product(
          id: json.decode(response.body)['name'],
          title: product.title,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl);
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      // print("my error message");
      // print(error);
      // print("my error message");
      rethrow;
    }
  }

  void updateProduct(String productId, Product newProduct) {
    final prodIdx = _items.indexWhere((element) => element.id == productId);
    if (prodIdx < 0) {
      return;
    }
    _items[prodIdx] = newProduct;
    notifyListeners();
  }

  void deleteProduct(String id) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
