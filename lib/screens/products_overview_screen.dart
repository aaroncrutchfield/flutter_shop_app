import 'package:flutter/material.dart';
import 'package:flutter_shop_app/dummy_data.dart';
import 'package:flutter_shop_app/models/product.dart';
import 'package:flutter_shop_app/widget/product_item.dart';
import 'package:flutter_shop_app/widget/products_grid.dart';

class ProductsOverviewScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
      ),
      body: ProductsGrid(),
    );
  }
}


