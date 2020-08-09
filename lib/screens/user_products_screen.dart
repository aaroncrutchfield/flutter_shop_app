import 'package:flutter/material.dart';
import 'package:flutter_shop_app/providers/products_provider.dart';
import 'package:flutter_shop_app/screens/edit_product_screen.dart';
import 'package:flutter_shop_app/widget/main_drawer.dart';
import 'package:flutter_shop_app/widget/user_product_widget.dart';
import 'package:provider/provider.dart';

class UserProductsScreen extends StatelessWidget {
  static const ROUTE = '/user-products';

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Products'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Navigator.of(context).pushNamed(EditProductScreen.ROUTE),
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: productsProvider.products.length,
          itemBuilder: (_, index) => UserProductWidget(
            id: productsProvider.products[index].id,
            title: productsProvider.products[index].title,
            imageUrl: productsProvider.products[index].imageUrl,
          ),
        ),
      ),
    );
  }
}
