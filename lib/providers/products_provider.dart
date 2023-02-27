import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';
import './product_provider.dart';

class Products with ChangeNotifier {
  // ignore: prefer_final_fields
  List<Product> _items = [];
  final String? authToken;

  Products(this.authToken, this._items);

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
        "https://learning-flutter-72888-default-rtdb.europe-west1.firebasedatabase.app/products.json?auth=$authToken");
    try {
      final response = await http.get(url);
      final data = jsonDecode(response.body);
      final List<Product> loadedProducts = [];
      if (data == null) return;
      data.forEach((prodId, prodData) {
        loadedProducts.add(Product(
          id: prodId,
          title: prodData['title'],
          description: prodData['description'],
          price: prodData['price'],
          imageUrl: prodData['imageUrl'],
          isFavourite: prodData['isFavourite'] ?? false,
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
        "https://learning-flutter-72888-default-rtdb.europe-west1.firebasedatabase.app/products.json?auth=$authToken");
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

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIdx = _items.indexWhere((element) => element.id == id);
    if (prodIdx < 0) return;
    final url = Uri.parse(
        "https://learning-flutter-72888-default-rtdb.europe-west1.firebasedatabase.app/products/$id.json?auth$authToken");
    await http.patch(url,
        body: json.encode({
          'title': newProduct.title,
          'description': newProduct.description,
          'imageUrl': newProduct.imageUrl,
          'price': newProduct.price,
        }));
    _items[prodIdx] = newProduct;
    notifyListeners();
  }

  void deleteProduct(String id) {
    final url = Uri.parse(
        "https://learning-flutter-72888-default-rtdb.europe-west1.firebasedatabase.app/products/$id.json?auth$authToken");
    final existingProductIndex =
        _items.indexWhere((element) => element.id == id);
    var existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    http.delete(url).then((response) {
      if (response.statusCode >= 400) {
        throw HttpException('Could not delete');
      }
    }).catchError((_) {
      _items.insert(existingProductIndex, existingProduct);
    });

    notifyListeners();
  }
}
