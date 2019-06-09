import 'package:flutter/material.dart';
import 'package:flutter_course/models/product.dart';
import 'package:flutter_course/scoped_model/main.dart';
import 'dart:async';

import 'package:flutter_course/widgets/ui_elements/title_default.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductPage extends StatelessWidget {
  final int index;

  ProductPage(this.index);

  Widget _buildAddressPriceRow(double price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Union Square,San Francisco",
          style: TextStyle(fontFamily: 'Oswald', color: Colors.grey),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          child: Text(
            "|",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
        Text(
          '\$' + price.toString(),
          style: TextStyle(fontFamily: 'Oswald', color: Colors.grey),
        )
      ],
    );
  }

  _showWarning(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Are you sure?"),
            content: Text("This cannot be undone."),
            actions: <Widget>[
              FlatButton(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text("Delete"),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context, true);
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
          Product product = model.allProducts[index];
          return Scaffold(
            appBar: AppBar(
              title: Text(product.title),
            ),
            body: Column(
              children: <Widget>[
                Image.asset(product.image),
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: TitleDefault(product.title),
                ),
                _buildAddressPriceRow(product.price),
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: Text(product.description),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
