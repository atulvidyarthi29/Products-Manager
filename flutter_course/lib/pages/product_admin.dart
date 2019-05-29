import 'package:flutter/material.dart';
import 'package:flutter_course/pages/create_product.dart';
import 'list_product.dart';

class ProductAdminPage extends StatelessWidget {
  final Function addProduct;
  final Function deleteProduct;

  ProductAdminPage(this.addProduct, this.deleteProduct);

  Widget _buildSideDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: Text("Choose"),
          ),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text("All Product"),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/products');
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          drawer: _buildSideDrawer(context),
          appBar: AppBar(
            title: Text('Manage Your Products'),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  text: "Create Product",
                  icon: Icon(Icons.create),
                ),
                Tab(
                  text: "List Product",
                  icon: Icon(Icons.list),
                )
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[CreateProduct(addProduct), ListProduct()],
          )),
    );
  }
}
