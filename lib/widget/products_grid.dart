import 'package:flutter/material.dart';
import 'package:flutter_shop_app/models/product.dart';
import 'package:flutter_shop_app/providers/products_provider.dart';
import 'package:provider/provider.dart';

import 'product_item.dart';

class ProductsGrid extends StatelessWidget {

	@override
	Widget build(BuildContext context) {
		final productsProvider = context.watch<ProductsProvider>();
		final List<Product> products = productsProvider.products;

		return GridView.builder(
			padding: const EdgeInsets.all(10),
			itemCount: products.length,
			itemBuilder: (ctx, index) => ChangeNotifierProvider(
			  create: (ctx) => products[index],
				child: ProductItem(),
			),
			gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
				crossAxisCount: 2,
				childAspectRatio: 3 / 2,
				crossAxisSpacing: 10,
				mainAxisSpacing: 10,
			),
		);
	}
}