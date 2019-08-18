import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:picturie/src/ui/tab_view/tab_view.dart';

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
        onPressed: () async {
          String _email = widget._emailController.text;
          String _password = widget._passwordController.text;
          // print(widget._emailController.text);
          // print(widget._passwordController.text);
          try {
            FirebaseUser userId = await FirebaseAuth.instance
                .signInWithEmailAndPassword(email: _email, password: _password);

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeTabView(),
              ),
            );
          } catch (e) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('Invalid Credentials'),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 3),
              ),
            );
            print(e.message);
          }
        },
      ),
    );
  }
}
