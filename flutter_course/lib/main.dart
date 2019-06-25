import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:flutter_course/models/product.dart';
import 'package:flutter_course/pages/auth.dart';
import 'package:flutter_course/pages/home.dart';
import 'package:flutter_course/pages/product_admin.dart';
import 'package:flutter_course/pages/product_page.dart';
import 'package:flutter_course/scoped_model/main.dart';

void main() {
  // debugPaintSizeEnabled = true;
  // debugPaintBaselinesEnabled = true;
  // debugPaintPointersEnabled = true;
  // MapView.setApiKey('AIzaSyAR2MrACxQ2WwZQ5uHs5urL-fj9VQ9Q9g0');
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final MainModel _model = MainModel();
  bool _isauthenticated = false;

  @override
  void initState() {
    _model.autoAuthenticate();
    _model.userSubject.listen((bool isauthenticated) {
      setState(() {
        _isauthenticated = isauthenticated;
      });
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: _model,
      child: MaterialApp(
        theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.deepPurple,
            accentColor: Colors.green,
            buttonColor: Colors.green),
        routes: {
          '/': (BuildContext context) =>
              !_isauthenticated ? AuthPage() : HomePage(_model),
          '/admin': (BuildContext context) =>
              !_isauthenticated ? AuthPage() : ProductAdminPage(_model),
        },
        onGenerateRoute: (RouteSettings settings) {
          if (!_isauthenticated) {
            return MaterialPageRoute(
                builder: (BuildContext context) => AuthPage());
          }

          final List<String> path = settings.name.split('/');
          if (path[0] != '') {
            return null;
          }
          if (path[1] == 'products') {
            final String productId = path[2];
            Product product = _model.allProducts.firstWhere((Product pdt) {
              return pdt.id == productId;
            });
            return MaterialPageRoute<bool>(
                builder: (BuildContext context) =>
                    !_isauthenticated ? AuthPage() : ProductPage(product));
          }
          return null;
        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(
              builder: (BuildContext context) =>
                  !_isauthenticated ? AuthPage() : HomePage(_model));
        },
      ),
    );
  }
}
