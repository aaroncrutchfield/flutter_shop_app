import 'package:flutter/material.dart';
import 'package:flutter_shop_app/providers/orders.dart';
import 'package:intl/intl.dart';

class OrderWidget extends StatelessWidget {
	final OrderItem orderItem;

	OrderWidget({@required this.orderItem});

	@override
  Widget build(BuildContext context) {
    return Card(
	    margin: EdgeInsets.all(10),
	    child: Column(
		    children: <Widget>[
		    	ListTile(
				    title: Text('\$${orderItem.amount}'),
				    subtitle: Text(DateFormat('dd/MM/yyyy - hh:mm').format(orderItem.dateTime)),
				    trailing: IconButton(
					    icon: Icon(Icons.expand_more),
					    onPressed: (){},
				    ),
			    )
		    ],
	    ),
    );
  }
}
