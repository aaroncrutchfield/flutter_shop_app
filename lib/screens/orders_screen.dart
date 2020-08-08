import 'package:flutter/material.dart';
import 'package:flutter_shop_app/providers/orders.dart';
import 'package:flutter_shop_app/widget/main_drawer.dart';
import 'package:flutter_shop_app/widget/order_widget.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  static const ROUTE = '/orders';
  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<OrdersProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      body: ListView.builder(
        itemCount: ordersProvider.orders.length,
        itemBuilder: (ctx, index) =>
            OrderWidget(orderItem: ordersProvider.orders[index]),
      ),
      drawer: MainDrawer(),
    );
  }
}
