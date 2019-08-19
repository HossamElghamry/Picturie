import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:picturie/src/authentication_bloc.dart';
import 'package:picturie/src/common/sign_in_data.dart';
import 'package:picturie/src/ui/tab_view/tab_view.dart';
import 'package:provider/provider.dart';

class SignInButton extends StatefulWidget {
  GlobalKey<FormState> _formKey;
  final SignInData _data;
  SignInButton({Key key, formKey, data})
      : _formKey = formKey,
        _data = data;

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
            Future<FirebaseUser> user = _authService
                .picturieSignIn(widget._data.email, widget._data.password)
                .catchError((e) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('Invalid Credentials'),
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
            });
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
