import 'package:flutter/material.dart';
import 'package:flutter_shop_app/dummy_data.dart';
import 'package:flutter_shop_app/models/product.dart';

class ProductsProvider with ChangeNotifier {
	List<Product> _products = DUMMY_PRODUCTS;

	List<Product> get products {
		return [..._products];
	}

	void addProduct() {
//		_products.add(value);
		notifyListeners();
	}
}