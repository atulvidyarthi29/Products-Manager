import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_course/widgets/ui_elements/title_default.dart';

class ProductPage extends StatelessWidget {
  final String title;
  final String imageurl;
  final String description;
  final double price;

  ProductPage(this.title, this.imageurl, this.price, this.description);

  Widget _buildAddressPriceRow() {
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
          price.toString(),
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
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Column(
          children: <Widget>[
            Image.asset(imageurl),
            Container(
              padding: EdgeInsets.all(10.0),
              child: TitleDefault(title),
            ),
            _buildAddressPriceRow(),
            Container(
              padding: EdgeInsets.all(10.0),
              child: RaisedButton(
                  color: Theme.of(context).accentColor,
                  textColor: Colors.white,
                  child: Text("Delete"),
                  onPressed: () => _showWarning(context)),
            ),
          ],
        ),
      ),
    );
  }
}
