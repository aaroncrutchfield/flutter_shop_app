import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
	  @required this.title,
	  @required this.description,
	  @required this.price,
	  @required this.imageUrl,
	  this.isFavorite = false,
  });

  void toggleFavoriteStatus() {
  	isFavorite = !isFavorite;
  	notifyListeners();
  }

  Map<String, String> toJson() {
  	return {
  		'title': title,
		  'description': description,
		  'price': price.toString(),
		  'imageUrl': imageUrl,
		  'isFavorite': isFavorite.toString(),
	  };
  }
}
