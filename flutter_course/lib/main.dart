import 'package:flutter/material.dart';
import 'package:flutter_course/models/product.dart';
// import 'package:flutter/rendering.dart';
import 'package:flutter_course/pages/auth.dart';
import 'package:flutter_course/pages/home.dart';
import 'package:flutter_course/pages/product_admin.dart';
import 'package:flutter_course/pages/product_page.dart';
import 'package:flutter_course/scoped_model/main.dart';
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
    final MainModel model = MainModel();
    return ScopedModel<MainModel>(
      model: model,
      child: MaterialApp(
        theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.deepPurple,
            accentColor: Colors.green,
            buttonColor: Colors.green),
        routes: {
          '/': (BuildContext context) => AuthPage(),
          '/products': (BuildContext context) => HomePage(model),
          '/admin': (BuildContext context) => ProductAdminPage(model),
        },
        onGenerateRoute: (RouteSettings settings) {
          final List<String> path = settings.name.split('/');
          if (path[0] != '') {
            return null;
          }
          if (path[1] == 'products') {
            final String productId = path[2];
            Product product = model.allProducts.firstWhere((Product pdt){
                return pdt.id == productId;
            }); 
            return MaterialPageRoute<bool>(
                builder: (BuildContext context) =>
                    ProductPage(product));
          }
          return null;
        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(
              builder: (BuildContext context) => HomePage(model));
        },
      ),
    );
  }
}
