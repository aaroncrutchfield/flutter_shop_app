import 'package:flutter/material.dart';
import 'package:flutter_shop_app/providers/orders.dart';
import 'package:flutter_shop_app/widget/main_drawer.dart';
import 'package:flutter_shop_app/widget/order_widget.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  static const ROUTE = '/orders';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isLoading = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero).then((_) async {
      setState(() => _isLoading = true);
      await context.read<OrdersProvider>().fetchAndSetOrders();
      setState(() => _isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<OrdersProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: ordersProvider.orders.length,
              itemBuilder: (ctx, index) =>
                  OrderWidget(orderItem: ordersProvider.orders[index]),
            ),
      drawer: MainDrawer(),
    );
  }
}
