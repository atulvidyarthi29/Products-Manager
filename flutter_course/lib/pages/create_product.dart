import 'package:flutter/material.dart';

class CreateProduct extends StatefulWidget {
  final Function addProduct;

  CreateProduct(this.addProduct);

  @override
  State<StatefulWidget> createState() {
    return _CreateProductState();
  }
}

class _CreateProductState extends State<CreateProduct> {
  final Map<String, dynamic> _formdata = {
    'title': null,
    'description': null,
    'price': null,
    'image': 'assets/food.jpg',
  };
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  void _submitform() {
    if (!_formkey.currentState.validate()) return;
    _formkey.currentState.save();
    widget.addProduct(_formdata);
    Navigator.pushReplacementNamed(context, '/products');
  }

  Widget _buildTitleTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Product Name"),
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

  Widget _buildDescriptionTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Product Description"),
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

  Widget _buildPriceTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Product Price"),
      keyboardType: TextInputType.number,
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

  @override
  Widget build(BuildContext context) {
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
}
