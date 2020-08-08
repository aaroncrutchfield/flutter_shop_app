import 'package:flutter/material.dart';

class UserProductWidget extends StatelessWidget {
  final String title;
  final String imageUrl;

  UserProductWidget({
    @required this.title,
    @required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
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
                IconButton(icon: Icon(Icons.edit), onPressed: (){}, color: Theme.of(context).primaryColor,),
                IconButton(icon: Icon(Icons.delete), onPressed: (){}, color: Theme.of(context).errorColor,),
              ],
            ),
          ),
        ),
        Divider(),
      ],
    );
  }
}
