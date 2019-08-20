import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:picturie/src/authentication_bloc.dart';
import 'package:picturie/src/common/sign_in_data.dart';
import 'package:provider/provider.dart';

class SignInButton extends StatefulWidget {
  final GlobalKey<FormState> _formKey;
  final SignInData _data;
  final GlobalKey<ScaffoldState> _scaffoldKey;
  SignInButton({Key key, formKey, data, scaffoldKey})
      : _formKey = formKey,
        _data = data,
        _scaffoldKey = scaffoldKey;

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
          if (widget._formKey.currentState.validate()) {
            widget._formKey.currentState.save();
            try {
              FirebaseUser user = await _authService.picturieSignIn(
                  widget._data.email, widget._data.password);
            } on Exception catch (e) {
              widget._scaffoldKey.currentState.showSnackBar(
                SnackBar(
                  content: Text('Invalid credentials'),
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 3),
                  action: SnackBarAction(
                    label: "Tap to hide",
                    textColor: Colors.black,
                    onPressed: () {
                      Scaffold.of(context).hideCurrentSnackBar();
                    },
                  ),
                ),
              );
              _authService.cancelLoad();
            }
          } else {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('There are invalid input data'),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 3),
                action: SnackBarAction(
                  label: "Tap to Hide",
                  textColor: Colors.black,
                  onPressed: () {
                    Scaffold.of(context).hideCurrentSnackBar();
                  },
                ),
              ),
            );
          }

          // _authService.signOut();
        },
      ),
    );
  }
}
