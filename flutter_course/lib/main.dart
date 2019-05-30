import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'package:flutter_course/pages/auth.dart';
import 'package:flutter_course/pages/home.dart';
import 'package:flutter_course/pages/product_admin.dart';
import 'package:flutter_course/pages/product_page.dart';
import 'package:flutter_course/scoped_model/products.dart';
import 'package:scoped_model/scoped_model.dart';

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
  Widget build(BuildContext context) {
    return ScopedModel<ProductModel>(
      model: ProductModel(),
      child: MaterialApp(
        theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.deepPurple,
            accentColor: Colors.green,
            buttonColor: Colors.green),
        routes: {
          '/': (BuildContext context) => AuthPage(),
          '/products': (BuildContext context) => HomePage(),
          '/admin': (BuildContext context) => ProductAdminPage(),
        },
        onGenerateRoute: (RouteSettings settings) {
          final List<String> path = settings.name.split('/');
          if (path[0] != '') {
            return null;
          }
          if (path[1] == 'products') {
            final int index = int.parse(path[2]);
            return MaterialPageRoute<bool>(
                builder: (BuildContext context) =>
                    ProductPage(index));
          }
          return null;
        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(
              builder: (BuildContext context) => HomePage());
        },
      ),
    );
  }
}
