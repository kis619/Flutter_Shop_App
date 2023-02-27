import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import './cart_provider.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  final List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final timeStamp = DateTime.now();
    final url = Uri.parse(
        'https://learning-flutter-72888-default-rtdb.europe-west1.firebasedatabase.app/orders.json');
    final response = await http.post(url,
        body: jsonEncode({
          'amount': total,
          'datetime': timeStamp.toIso8601String(),
          'products': cartProducts.map((product) => {
            'id': product.id,
            'title': product.title,
            'quantity': product.quantity,
            'price': product.price,
          }).toList(),
        }));

    _orders.insert(
        0,
        OrderItem(
            id: jsonDecode(response.body)['name'],
            amount: total,
            products: cartProducts,
            dateTime: timeStamp));
    notifyListeners();
  }
}
