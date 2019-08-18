import 'package:flutter/material.dart';

class SignInButton extends StatefulWidget {
  final TextEditingController _emailController;
  final TextEditingController _passwordController;

  SignInButton({Key key, emailController, passwordController})
      : _emailController = emailController,
        _passwordController = passwordController;

  @override
  _SignInButtonState createState() => _SignInButtonState();
}

class _SignInButtonState extends State<SignInButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        shape: StadiumBorder(),
        color: Colors.teal,
        child: Text(
          "Sign In",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        onPressed: () {
          print(widget._emailController.text);
          print(widget._passwordController.text);
        },
      ),
    );
  }
}
