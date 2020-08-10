import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_shop_app/models/product.dart';
import 'package:http/http.dart' as http;

class ProductsProvider with ChangeNotifier {
  static const url =
      'https://flutter-tutorial-a24fd.firebaseio.com/products.json';

  List<Product> _products = [];

  List<Product> get products {
    return [..._products];
  }

  Future<void> addProduct(Product product) async {
    try {
      final response = await http.post(
        url,
        body: product.toJson(),
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
      final jsonData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      jsonData.forEach((productId, productData) {
        loadedProducts.add(Product.fromJson(productId, productData));
      });
      _products = loadedProducts;
      notifyListeners();
      print(json.decode(response.body));
    } catch (error) {
      print(error);
      throw (error);
    }
  }

  List<Product> get favoriteProducts {
    return _products.where((product) => product.isFavorite).toList();
  }

  Product findById(String productId) {
    return _products.firstWhere((product) => product.id == productId);
  }

  Future<void> updateProduct(Product editedProduct) async {
    var indexWhere = _products
        .indexWhere((currentProduct) => currentProduct.id == editedProduct.id);
    if (indexWhere >= 0) {
      final url =
          'https://flutter-tutorial-a24fd.firebaseio.com/products/${editedProduct.id}.json';
      print(url);
      await http.patch(url, body: editedProduct.toJson());
      _products[indexWhere] = editedProduct;
    }
    notifyListeners();
  }

  void deleteProduct(String id) {
    final url =
        'https://flutter-tutorial-a24fd.firebaseio.com/products/$id.json';
    final existingIndex = _products.indexWhere((product) => product.id == id);
    var existingProduct = _products[existingIndex];
    _products.removeAt(existingIndex);

    http.delete(url)
        .then((response) {
          if (response.statusCode >= 400) {

          }
          return existingProduct = null;
        });
    _products.removeWhere((product) => product.id == id);
    notifyListeners();
  }
}
