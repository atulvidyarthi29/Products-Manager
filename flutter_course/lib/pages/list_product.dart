import 'package:flutter/material.dart';
import 'package:flutter_course/models/product.dart';
import 'package:flutter_course/pages/product_edit.dart';

class ListProduct extends StatelessWidget {
  final List<Product> products;
  final Function updateProduct;
  final Function deleteProduct;

  ListProduct(this.products, this.updateProduct, this.deleteProduct);

  Widget _buildEditButton(BuildContext context, int index) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext contet) => ProductEditPage(
                  index: index,
                  product: products[index],
                  updateProduct: updateProduct,
                ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          key: Key(products[index].title),
          onDismissed: (DismissDirection direction) {
            if (direction == DismissDirection.endToStart) deleteProduct(index);
          },
          background: Container(
            color: Colors.red,
          ),
          child: Column(
            children: <Widget>[
              ListTile(
                contentPadding: EdgeInsets.all(10.0),
                leading: CircleAvatar(
                  backgroundImage: AssetImage(products[index].image),
                ),
                title: Text(products[index].title),
                subtitle: Text('\$ ' + products[index].price.toString()),
                trailing: _buildEditButton(context, index),
              ),
              Divider()
            ],
          ),
        );
      },
    );
  }
}
