import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
	static const ROUTE = '/product-detail';

//	final String title;
//  final double price;
//
//
//
//  ProductDetailsScreen(this.title, this.price);

  @override
  Widget build(BuildContext context) {
  	final productId = ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
	    appBar: AppBar(title: Text('title'),),
    );
  }
}
