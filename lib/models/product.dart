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

  Product.fromJson(String id, dynamic data) :
			  this.id = id,
			  this.title = data['title'],
			  this.description = data['description'],
			  this.price = double.parse(data['price']),
			  this.imageUrl = data['imageUrl'],
			  this.isFavorite = toBool(data['isFavorite']);


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

  static bool toBool(String value) {
  	if (value == 'true' || value == 'True') return true;
  	else return false;
  }
}
