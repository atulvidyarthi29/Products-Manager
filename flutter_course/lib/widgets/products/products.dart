import 'package:flutter/material.dart';
import 'package:flutter_course/models/product.dart';
import 'package:flutter_course/scoped_model/products.dart';
import 'package:flutter_course/widgets/products/product_card.dart';
import 'package:scoped_model/scoped_model.dart';

class Products extends StatelessWidget {
  Widget _buildListProducts(List<Product> products) {
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
    return ScopedModelDescendant<ProductModel>(
      builder: (BuildContext context, Widget child, ProductModel model) {
        return _buildListProducts(model.products);
      },
    );
  }
}
