import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_shop_app/models/http_exception.dart';
import 'package:http/http.dart' as http;

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


  Future<void> toggleFavoriteStatus() async {
  	final oldStatus = isFavorite;
  	isFavorite = !isFavorite;
  	notifyListeners();
	  final url = 'https://flutter-tutorial-a24fd.firebaseio.com/products/$id.json';
	  try {
	    var response = await http.patch(url, body: this.toJson());
	    if (response.statusCode >= 400) {
		    _setFavStatus(oldStatus);
	    	throw HttpException('Couldn\'t update the favorite status');
	    }
	  } catch (error) {
	    _setFavStatus(oldStatus);
	  }
  }

  void _setFavStatus(bool oldStatus) {
    isFavorite = oldStatus;
    notifyListeners();
  }

  String toJson() {
  	return json.encode({
  		'title': title,
		  'description': description,
		  'price': price.toString(),
		  'imageUrl': imageUrl,
		  'isFavorite': isFavorite.toString(),
	  });
  }

  static bool toBool(String value) {
  	if (value == 'true' || value == 'True') return true;
  	else return false;
  }
}
