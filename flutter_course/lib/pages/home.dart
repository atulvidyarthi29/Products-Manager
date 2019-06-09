import 'package:flutter/material.dart';
import 'package:flutter_course/scoped_model/main.dart';
import 'package:flutter_course/widgets/products/products.dart';
import 'package:scoped_model/scoped_model.dart';

class HomePage extends StatelessWidget {
  Widget _buildSideDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: Text("Choose"),
          ),
          ListTile(
            leading: Icon(Icons.create),
            title: Text("Manage Product"),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/admin');
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildSideDrawer(context),
      appBar: AppBar(
        title: Text('All Products'),
        actions: <Widget>[
          ScopedModelDescendant<MainModel>(
            builder: (BuildContext context, Widget child, MainModel model) {
              return IconButton(
                icon: Icon(Icons.favorite),
                color: model.displayFavMode ? Colors.red : Colors.white,
                onPressed: () {
                  model.toggleDiplayMode();
                },
              );
            },
          )
        ],
      ),
      body: Products(),
    );
  }
}
