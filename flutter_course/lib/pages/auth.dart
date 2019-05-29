import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPage();
  }
}

class _AuthPage extends State<AuthPage> {
  String email;
  String password;
  bool _acceptTerms = false;

  DecorationImage _buildBackgroundImage() {
    return DecorationImage(
      fit: BoxFit.cover,
      colorFilter:
          ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.dstATop),
      image: AssetImage('assets/background.jpg'),
    );
  }

  Widget _buildEmailTextField() {
    return TextField(
      decoration: InputDecoration(
        labelText: "Email",
        filled: true,
        fillColor: Colors.white,
      ),
      keyboardType: TextInputType.emailAddress,
      onChanged: (String value) {
        setState(() {
          email = value;
        });
      },
    );
  }

  _buildPasswordTextField() {
    return TextField(
      decoration: InputDecoration(
        labelText: "Password",
        filled: true,
        fillColor: Colors.white,
      ),
      obscureText: true,
      onChanged: (String value) {
        setState(() {
          password = value;
        });
      },
    );
  }

  Widget _buildSwitch() {
    return SwitchListTile(
      value: _acceptTerms,
      title: Text("Accept Terms"),
      onChanged: (bool value) {
        setState(() {
          _acceptTerms = value;
        });
      },
    );
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
              child: Column(
                children: <Widget>[
                  _buildEmailTextField(),
                  SizedBox(
                    height: 10.0,
                  ),
                  _buildPasswordTextField(),
                  _buildSwitch(),
                  SizedBox(height: 10.0),
                  RaisedButton(
                    child: Text("Login"),
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/products');
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
