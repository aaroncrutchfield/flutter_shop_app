import 'package:flutter/material.dart';
import 'package:flutter_shop_app/providers/products_provider.dart';
import 'package:provider/provider.dart';


class ProductDetailsScreen extends StatelessWidget {
	static const ROUTE = '/product-detail';


  @override
  Widget build(BuildContext context) {
	  final productId = ModalRoute.of(context).settings.arguments as String;
	  final product = context.select((ProductsProvider provider) => provider.findById(productId));

    return Scaffold(
	    appBar: AppBar(title: Text(product.title),),
    );
  }
}
