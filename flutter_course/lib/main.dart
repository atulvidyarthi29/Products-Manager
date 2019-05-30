import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'package:flutter_course/pages/auth.dart';
import 'package:flutter_course/pages/home.dart';
import 'package:flutter_course/pages/product_admin.dart';
import 'package:flutter_course/pages/product_page.dart';

import 'models/product.dart';

void main() {
  // debugPaintSizeEnabled = true;
  // debugPaintBaselinesEnabled = true;
  // debugPaintPointersEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  List<Product> _products = [];

  void _addProduct(Product prod) {
    setState(() {
      _products.add(prod);
    });
  }

  void _deleteProduct(int index) {
    setState(() {
      _products.removeAt(index);
    });
  }

  void _updateProduct(int index, Product product) {
    setState(() {
      _products[index] = product;
    });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.deepPurple,
          accentColor: Colors.green,
          buttonColor: Colors.green),
      routes: {
        '/': (BuildContext context) => AuthPage(),
        '/products': (BuildContext context) => HomePage(_products),
        '/admin': (BuildContext context) => ProductAdminPage(
            _addProduct, _deleteProduct, _updateProduct, _products),
      },
      onGenerateRoute: (RouteSettings settings) {
        final List<String> path = settings.name.split('/');
        if (path[0] != '') {
          return null;
        }
        if (path[1] == 'products') {
          final int index = int.parse(path[2]);
          return MaterialPageRoute<bool>(
              builder: (BuildContext context) => ProductPage(
                  _products[index].title,
                  _products[index].image,
                  _products[index].price,
                  _products[index].description));
        }
        return null;
      },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            builder: (BuildContext context) => HomePage(_products));
      },
    );
  }
}
