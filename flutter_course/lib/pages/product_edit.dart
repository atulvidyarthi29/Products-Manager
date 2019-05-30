import 'package:flutter/material.dart';
import 'package:flutter_course/helpers/ensure_visible.dart';
import 'package:flutter_course/models/product.dart';

class ProductEditPage extends StatefulWidget {
  final Function addProduct;
  final Function updateProduct;
  final Product product;
  final int index;

  ProductEditPage(
      {this.addProduct, this.product, this.updateProduct, this.index});

  @override
  State<StatefulWidget> createState() {
    return _ProductEditPageState();
  }
}

class _ProductEditPageState extends State<ProductEditPage> {
  final Map<String, dynamic> _formdata = {
    'title': null,
    'description': null,
    'price': null,
    'image': 'assets/food.jpg',
  };
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final _titleFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _priceFocusNode = FocusNode();

  void _submitform() {
    if (!_formkey.currentState.validate()) return;
    _formkey.currentState.save();

    if (widget.product == null)
      widget.addProduct(Product(
        title: _formdata['title'],
        description: _formdata['description'],
        price: _formdata['price'],
        image: _formdata['image'],
      ));
    else {
      print(widget.product.title);
      widget.updateProduct(
          widget.index,
          Product(
            title: _formdata['title'],
            description: _formdata['description'],
            price: _formdata['price'],
            image: _formdata['image'],
          ));
    }

    Navigator.pushReplacementNamed(context, '/products');
  }

  Widget _buildTitleTextField() {
    return EnsureVisibleWhenFocused(
      focusNode: _titleFocusNode,
      child: TextFormField(
        focusNode: _titleFocusNode,
        decoration: InputDecoration(labelText: "Product Name"),
        initialValue: widget.product == null ? '' : widget.product.title,
        validator: (String value) {
          if (value.isEmpty || value.length < 4) {
            return "Title is required and should be 4+ characters";
          }
        },
        onSaved: (String value) {
          _formdata['title'] = value;
        },
      ),
    );
  }

  Widget _buildDescriptionTextField() {
    return EnsureVisibleWhenFocused(
      focusNode: _descriptionFocusNode,
      child: TextFormField(
        focusNode: _descriptionFocusNode,
        decoration: InputDecoration(labelText: "Product Description"),
        initialValue: widget.product == null ? '' : widget.product.description,
        maxLines: 4,
        validator: (String value) {
          if (value.isEmpty) {
            return "Description is required";
          }
        },
        onSaved: (String value) {
          _formdata['description'] = value;
        },
      ),
    );
  }

  Widget _buildPriceTextField() {
    return EnsureVisibleWhenFocused(
      focusNode: _priceFocusNode,
      child: TextFormField(
        focusNode: _priceFocusNode,
        decoration: InputDecoration(labelText: "Product Price"),
        keyboardType: TextInputType.number,
        initialValue:
            widget.product == null ? '' : widget.product.price.toString(),
        validator: (String value) {
          if (value.isEmpty ||
              !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
            return "Price is required and should be a number.";
          }
        },
        onSaved: (String value) {
          _formdata['price'] = double.parse(value);
        },
      ),
    );
  }

  Widget _buildProductContent(BuildContext context) {
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
              _buildTitleTextField(),
              _buildDescriptionTextField(),
              _buildPriceTextField(),
              SizedBox(height: 10.0),
              RaisedButton(
                textColor: Colors.white,
                child: Text("Save"),
                onPressed: _submitform,
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget productContent = _buildProductContent(context);
    return widget.product == null
        ? productContent
        : Scaffold(
            appBar: AppBar(
              title: Text(
                'Edit Product',
              ),
            ),
            body: productContent,
          );
  }
}
