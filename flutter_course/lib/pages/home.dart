import 'package:flutter/material.dart';
import 'package:flutter_course/product_manager.dart';

class HomePage extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  HomePage(this.products);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            AppBar(
              automaticallyImplyLeading: false,
              title: Text("Choose"),
            ),
            ListTile(
              title: Text("Manage Product"),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/admin');
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('All Products'),
      ),
      body: ProductManager(products),
    );
  }
}