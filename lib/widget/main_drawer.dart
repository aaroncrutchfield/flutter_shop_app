import 'package:flutter/material.dart';
import 'package:flutter_shop_app/screens/orders_screen.dart';
import 'package:flutter_shop_app/screens/user_products_screen.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Hello Friend!'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Shop'),
	          onTap: () => Navigator.of(context).pushReplacementNamed('/'),
          ),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Orders'),
	          onTap: () => Navigator.of(context).pushReplacementNamed(OrdersScreen.ROUTE),
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage Products'),
	          onTap: () => Navigator.of(context).pushReplacementNamed(UserProductsScreen.ROUTE),
          ),
        ],
      ),
    );
  }
}
