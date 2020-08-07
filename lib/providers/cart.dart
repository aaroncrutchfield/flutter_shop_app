import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem(
      {@required this.id,
      @required this.title,
      @required this.quantity,
      @required this.price});
}

class CartProvider with ChangeNotifier {
  Map<String, CartItem> _items;

  Map<String, CartItem> get items {
    return {..._items};
  }

  void addItem(String productId, double price, String title,) {
  	if (_items.containsKey(productId)) {
  		// change quantity
		  _items.update(productId, (existingItem) => CartItem(
			  id: existingItem.id,
			  title: existingItem.title,
			  price: existingItem.price,
			  quantity: existingItem.quantity + 1,
		  ));
	  } else {
  		_items.putIfAbsent(productId, () => CartItem(
			  id: DateTime.now().toString(),
			  title: title,
			  price: price,
			  quantity: 1,
		  ));
	  }
  }
}
