import 'package:flutter/material.dart';
import 'package:flutter_course/models/product.dart';
import 'package:flutter_course/widgets/products/product_card.dart';

class Products extends StatelessWidget {
  final List<Product> products;

  Products(this.products);

  Widget _buildListProducts() {
    Widget productcards =
        Center(child: Text("No Product found, please add one"));
    if (products.length > 0) {
      productcards = ListView.builder(
          itemBuilder: (BuildContext context, int index) =>
              ProductCard(products[index], index),
          itemCount: products.length);
    }
    return productcards;
  }

  @override
  Widget build(BuildContext context) {
    return _buildListProducts();
  }
}
