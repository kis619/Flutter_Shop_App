import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavourite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavourite = false,
  });

  Future<void> toggleFavouriteStatus(String? token, String? userId) async {
    final oldStatus = isFavourite;

    isFavourite = !isFavourite;
    notifyListeners();

    final url = Uri.parse(
        "https://learning-flutter-72888-default-rtdb.europe-west1.firebasedatabase.app/userFavourites/$userId/$id.json?auth=$token");
    try {
      final response = await http.put(
        url,
        body: jsonEncode(
          isFavourite,
        ),
      );
      if (response.statusCode >= 400) {
        isFavourite = oldStatus;
        notifyListeners();
      }
    } catch (error) {
      isFavourite = oldStatus;
      notifyListeners();
    }
  }
}
