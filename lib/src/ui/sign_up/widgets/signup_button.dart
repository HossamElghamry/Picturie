import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:picturie/src/authentication_bloc.dart';
import 'package:picturie/src/common/sign_up_data.dart';
import 'package:picturie/src/ui/profile_photo_signup/profile_photo_signup.dart';
import 'package:provider/provider.dart';

class SignUpSubmitButton extends StatefulWidget {
  final GlobalKey<FormState> _formKey;
  final SignUpData _data;
  final GlobalKey<ScaffoldState> _signUpScaffoldKey;

  SignUpSubmitButton({Key key, formKey, data, signUpScaffoldKey})
      : _formKey = formKey,
        _data = data,
        _signUpScaffoldKey = signUpScaffoldKey;

  @override
  _SignUpSubmitButtonState createState() => _SignUpSubmitButtonState();
}

class _SignUpSubmitButtonState extends State<SignUpSubmitButton> {
  @override
  Widget build(BuildContext context) {
    final AuthService _authService = Provider.of<AuthService>(context);
    return Container(
      width: double.infinity,
      child: RaisedButton(
        shape: StadiumBorder(),
        color: Colors.teal,
        child: Text(
          "Sign Up with Picturie",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        onPressed: () async {
          validateAndSignUp(_authService);
        },
      ),
    );
  }

  validateAndSignUp(_authService) async {
    if (widget._formKey.currentState.validate()) {
      widget._formKey.currentState.save();
      try {
        await _authService.picturieSignUp(widget._data);
        FirebaseUser user = await _authService.picturieSignIn(
            widget._data.email, widget._data.password);
        Navigator.of(widget._signUpScaffoldKey.currentContext).pushReplacement(
          MaterialPageRoute(
            builder: (context) => ProfilePhotoSignUp(),
          ),
        );
      } on Exception catch (e) {
        widget._signUpScaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text('Email already exists'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
            action: SnackBarAction(
              label: "Tap to Hide",
              textColor: Colors.black,
              onPressed: () {
                widget._signUpScaffoldKey.currentState.hideCurrentSnackBar();
              },
            ),
          ),
        );
        _authService.cancelLoad();
      }
    } else {
      widget._signUpScaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('There are invalid input data'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
          action: SnackBarAction(
            label: "Tap to Hide",
            textColor: Colors.black,
            onPressed: () {
              widget._signUpScaffoldKey.currentState.hideCurrentSnackBar();
            },
          ),
        ),
      );
    }
  }
}
