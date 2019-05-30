import 'package:flutter/material.dart';
import 'package:flutter_course/models/product.dart';
import 'package:flutter_course/widgets/products/address_tag.dart';
import 'package:flutter_course/widgets/products/price_tag.dart';
import 'package:flutter_course/widgets/ui_elements/title_default.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final int index;

  ProductCard(this.product, this.index);

  Widget _buildTitlePrice() {
    return Container(
      margin: EdgeInsets.only(top: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TitleDefault(product.title),
          SizedBox(width: 8.0),
          PriceTag(product.price)
        ],
      ),
    );
  }

  Widget _buildButtonBar(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          onPressed: () => Navigator.pushNamed<bool>(
                context,
                "/products/" + index.toString(),
              ),
          color: Theme.of(context).primaryColor,
          icon: Icon(Icons.info),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.favorite_border),
          color: Colors.red,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(product.image),
          _buildTitlePrice(),
          AddressTag("Union Square, San Francisco"),
          _buildButtonBar(context),
        ],
      ),
    );
  }
}
