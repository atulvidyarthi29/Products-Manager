import 'package:flutter/material.dart';
import 'package:flutter_course/models/product.dart';
import 'package:flutter_course/scoped_model/main.dart';
import 'package:flutter_course/widgets/products/product_card.dart';
import 'package:scoped_model/scoped_model.dart';

class Products extends StatelessWidget {
  Widget _buildListProducts(List<Product> products) {
    Widget productcards;
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
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return _buildListProducts(model.displayedProducts);
      },
    );
  }
}
