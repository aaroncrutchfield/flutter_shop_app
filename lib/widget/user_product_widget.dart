import 'package:flutter/material.dart';
import 'package:flutter_shop_app/providers/products_provider.dart';
import 'package:flutter_shop_app/screens/edit_product_screen.dart';
import 'package:provider/provider.dart';

class UserProductWidget extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserProductWidget({
    @required this.id,
    @required this.title,
    @required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(title),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
          ),
          trailing: Container(
            width: 100,
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(EditProductScreen.ROUTE, arguments: id);
                  },
                  color: Theme.of(context).primaryColor,
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    try {
                      Provider.of<ProductsProvider>(context, listen: false)
                          .deleteProduct(id);
                    } catch (error) {
                      scaffold.showSnackBar(SnackBar(
                        content: Text('Deleting failed'),
                      ));
                    }
                  },
                  color: Theme.of(context).errorColor,
                ),
              ],
            ),
          ),
        ),
        Divider(),
      ],
    );
  }
}
