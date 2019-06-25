import 'package:flutter/material.dart';

import 'package:flutter_course/models/auth.dart';
import 'package:flutter_course/scoped_model/main.dart';
import 'package:scoped_model/scoped_model.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPage();
  }
}

class _AuthPage extends State<AuthPage> {
  final Map<String, dynamic> _formData = {
    'email': null,
    'password': null,
    'acceptTerms': true
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  AuthMode _authmode = AuthMode.Login;

  DecorationImage _buildBackgroundImage() {
    return DecorationImage(
      fit: BoxFit.cover,
      colorFilter:
          ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.dstATop),
      image: AssetImage('assets/background.jpg'),
    );
  }

  Widget _buildEmailTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Email",
        filled: true,
        fillColor: Colors.white,
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                .hasMatch(value)) {
          return 'Please enter a valid email';
        }
      },
      onSaved: (String value) {
        _formData['email'] = value;
      },
    );
  }

  _buildPasswordTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Password",
        filled: true,
        fillColor: Colors.white,
      ),
      controller: _passwordController,
      validator: (String value) {
        if (value.isEmpty || value.length < 6) {
          return 'Password invalid';
        }
      },
      obscureText: true,
      onSaved: (String value) {
        _formData['password'] = value;
      },
    );
  }

  _buildPasswordConfirmTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Password",
        filled: true,
        fillColor: Colors.white,
      ),
      validator: (String value) {
        if (_passwordController.text != value) {
          return 'Password do not match';
        }
      },
      obscureText: true,
      onSaved: (String value) {
        _formData['password'] = value;
      },
    );
  }

  Widget _buildSwitch() {
    return SwitchListTile(
      value: _formData['acceptTerms'],
      title: Text("Accept Terms"),
      onChanged: (bool value) {
        setState(() {
          _formData['acceptTerms'] = value;
        });
      },
    );
  }

  _showWarning(BuildContext context, String error) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('An Error occured'),
            content: Text(error),
            actions: <Widget>[
              FlatButton(
                child: Text("Okay"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void _submitForm(Function authenticate) async {
    if (!_formKey.currentState.validate() || !_formData['acceptTerms']) {
      return;
    }
    _formKey.currentState.save();
    Map<String, dynamic> successInformation = await authenticate(
        _formData['email'], _formData['password'], _authmode);
    if (successInformation['success']) {
      // Navigator.pushReplacementNamed(context, '/');
    } else {
      _showWarning(context, successInformation['message']);
    }
  }

  @override
  Widget build(BuildContext context) {
    double targetWidth = MediaQuery.of(context).size.width;
    if (targetWidth > 568.0) targetWidth = 0.8 * targetWidth;
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: _buildBackgroundImage(),
        ),
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: targetWidth,
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    _buildEmailTextField(),
                    SizedBox(
                      height: 10.0,
                    ),
                    _buildPasswordTextField(),
                    SizedBox(height: 10.0),
                    _authmode == AuthMode.Signup
                        ? _buildPasswordConfirmTextField()
                        : Container(),
                    _authmode == AuthMode.Signup ? _buildSwitch() : Container(),
                    SizedBox(height: 10.0),
                    FlatButton(
                      child: Text(
                          "Switch to ${_authmode == AuthMode.Login ? 'SignUp' : 'Login'}"),
                      onPressed: () {
                        setState(() {
                          _authmode = (_authmode == AuthMode.Login)
                              ? AuthMode.Signup
                              : AuthMode.Login;
                        });
                      },
                    ),
                    ScopedModelDescendant<MainModel>(
                      builder: (BuildContext context, Widget child,
                          MainModel model) {
                        return model.isLoading
                            ? CircularProgressIndicator()
                            : RaisedButton(
                                child: Text(_authmode == AuthMode.Signup
                                    ? 'SignUp'
                                    : 'Login'),
                                textColor: Colors.white,
                                onPressed: () =>
                                    _submitForm(model.authenticate),
                              );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
