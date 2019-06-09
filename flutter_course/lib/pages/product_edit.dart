import 'package:flutter/material.dart';
import 'package:flutter_course/models/product.dart';
import 'package:flutter_course/scoped_model/main.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductEditPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProductEditPageState();
  }
}

class _ProductEditPageState extends State<ProductEditPage> {
  final Map<String, dynamic> _formdata = {
    'title': 'Atul',
    'description': null,
    'price': null,
    'image': 'assets/food.jpg',
  };
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  void _submitform(
      Function addProduct, Function updateProduct, Function selectProduct,
      [int selectedProductIndex]) {
    if (!_formkey.currentState.validate()) return;
    _formkey.currentState.save();

    if (selectedProductIndex == null)
      addProduct(
        _formdata['title'],
        _formdata['description'],
        _formdata['price'],
        _formdata['image'],
      );
    else {
      updateProduct(
        _formdata['title'],
        _formdata['description'],
        _formdata['price'],
        _formdata['image'],
      );
    }

    Navigator.pushReplacementNamed(context, '/products')
        .then((_) => selectProduct(null));
  }

  Widget _buildTitleTextField(Product product) {
    return TextFormField(
      decoration: InputDecoration(labelText: "Product Name"),
      initialValue: product == null ? '' : product.title,
      validator: (String value) {
        if (value.isEmpty || value.length < 4) {
          return "Title is required and should be 4+ characters";
        }
      },
      onSaved: (String value) {
        _formdata['title'] = value;
      },
    );
  }

  Widget _buildDescriptionTextField(Product product) {
    return TextFormField(
      decoration: InputDecoration(labelText: "Product Description"),
      initialValue: product == null ? '' : product.description,
      maxLines: 4,
      validator: (String value) {
        if (value.isEmpty) {
          return "Description is required";
        }
      },
      onSaved: (String value) {
        _formdata['description'] = value;
      },
    );
  }

  Widget _buildPriceTextField(Product product) {
    return TextFormField(
      decoration: InputDecoration(labelText: "Product Price"),
      keyboardType: TextInputType.number,
      initialValue: product == null ? '' : product.price.toString(),
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
          return "Price is required and should be a number.";
        }
      },
      onSaved: (String value) {
        _formdata['price'] = double.parse(value);
      },
    );
  }

  Widget _buildSubmitButton() {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        return RaisedButton(
          textColor: Colors.white,
          child: Text("Save"),
          onPressed: () => _submitform(model.addProduct, model.updateProduct,model.selectProduct,
              model.selectedProductIndex),
        );
      },
    );
  }

  Widget _buildProductContent(BuildContext context, Product product) {
    double devWidth = MediaQuery.of(context).size.width;
    double targetWidth = (devWidth > 568.0) ? devWidth * 0.95 : devWidth;
    double targetPadding = devWidth - targetWidth;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: Form(
          key: _formkey,
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: targetPadding,
            ),
            children: <Widget>[
              _buildTitleTextField(product),
              _buildDescriptionTextField(product),
              _buildPriceTextField(product),
              SizedBox(height: 10.0),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        Widget productContent =
            _buildProductContent(context, model.selectedProduct);
        return model.selectedProductIndex == null
            ? productContent
            : Scaffold(
                appBar: AppBar(
                  title: Text(
                    'Edit Product',
                  ),
                ),
                body: productContent,
              );
      },
    );
  }
}
