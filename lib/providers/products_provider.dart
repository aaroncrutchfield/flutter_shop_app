import 'package:flutter/material.dart';
import 'package:flutter_shop_app/dummy_data.dart';
import 'package:flutter_shop_app/models/product.dart';

class ProductsProvider with ChangeNotifier {
	List<Product> _products = DUMMY_PRODUCTS;

	List<Product> get products {
		return [..._products];
	}

	void addProduct(Product product) {
		final newProduct = Product(
			title: product.title,
			description: product.description,
			price: product.price,
			imageUrl: product.imageUrl,
			id: DateTime.now().toString(),
		);
		_products.add(newProduct);
		notifyListeners();
	}

	List<Product> get favoriteProducts {
		return _products.where((product) => product.isFavorite).toList();
	}

	Product findById(String productId) {
		return _products.firstWhere((product) => product.id == productId);
	}

  void updateProduct(Product editedProduct) {
		var indexWhere = _products.indexWhere((currentProduct) => currentProduct.id == editedProduct.id);
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