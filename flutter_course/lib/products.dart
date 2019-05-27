import 'package:flutter/material.dart';

class Products extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  Products(this.products);

  Widget _buildProductItem(BuildContext context, int index) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(products[index]['image']),
          Container(
            margin: EdgeInsets.all(10.0),
            child: Text(
              products[index]['title'],
              style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Oswald'),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                onPressed: () => Navigator.pushNamed<bool>(
                      context,
                      "/products/" + index.toString(),
                    ),
                child: Text('Details'),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildListProducts() {
    Widget productcards =
        Center(child: Text("No Product found, please add one"));
    if (products.length > 0) {
      productcards = ListView.builder(
          itemBuilder: _buildProductItem, itemCount: products.length);
    }
    return productcards;
  }

  @override
  Widget build(BuildContext context) {
    return _buildListProducts();
  }
}
