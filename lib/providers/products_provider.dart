import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_shop_app/dummy_data.dart';
import 'package:flutter_shop_app/models/product.dart';
import 'package:http/http.dart' as http;

class ProductsProvider with ChangeNotifier {
  static const url = 'https://flutter-tutorial-a24fd.firebaseio.com/products.json';

  List<Product> _products = DUMMY_PRODUCTS;

  List<Product> get products {
    return [..._products];
  }

  Future<void> addProduct(Product product) async {
    try {
      final response = await http.post(
        url,
        body: json.encode(product.toJson()),
      );

      final newProduct = Product(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        id: json.decode(response.body)['name'],
      );
      _products.add(newProduct);
      notifyListeners();

    } catch (error) {
       print(error);
       throw error;
    }
  }

  Future<void> fetchAndSetProducts() async {
    try {
      final response = await http.get(url);
      print(json.decode(response.body));
    } catch (error) {
      print(error);
      throw(error);
    }
  }

  List<Product> get favoriteProducts {
    return _products.where((product) => product.isFavorite).toList();
  }

  Product findById(String productId) {
    return _products.firstWhere((product) => product.id == productId);
  }

  void updateProduct(Product editedProduct) {
    var indexWhere = _products
        .indexWhere((currentProduct) => currentProduct.id == editedProduct.id);
    if (indexWhere >= 0) {
      _products[indexWhere] = editedProduct;
    }
    notifyListeners();
  }

  void deleteProduct(String id) {
    _products.removeWhere((product) => product.id == id);
    notifyListeners();
  }
}
