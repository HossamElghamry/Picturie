import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:picturie/src/authentication_bloc.dart';
import 'package:picturie/src/ui/tab_view/tab_view.dart';
import 'package:provider/provider.dart';

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
    final AuthService _authService = Provider.of<AuthService>(context);

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
        onPressed: () async {
          String _email = widget._emailController.text;
          String _password = widget._passwordController.text;
          // print(widget._emailController.text);
          // print(widget._passwordController.text);

          Future<FirebaseUser> user =
              _authService.picturieSignIn(_email, _password).catchError((e) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('Invalid Credentials'),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 3),
              ),
            );
          });
          // _authService.signOut();
        },
      ),
    );
  }
}
