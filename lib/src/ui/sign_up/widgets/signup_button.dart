import 'package:flutter/material.dart';
import 'package:picturie/src/authentication_bloc.dart';
import 'package:picturie/src/common/sign_in_data.dart';
import 'package:picturie/src/common/sign_up_data.dart';
import 'package:provider/provider.dart';

class SignUpSubmitButton extends StatefulWidget {
  GlobalKey<FormState> _formKey;
  final SignUpData _data;
  SignUpSubmitButton({Key key, formKey, data})
      : _formKey = formKey,
        _data = data;

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
          if (widget._formKey.currentState.validate()) {
            widget._formKey.currentState.save();
            await _authService.picturieSignUp(widget._data);
            await _authService.picturieSignIn(
                widget._data.email, widget._data.password);
            Navigator.of(context).pop();
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
        },
      ),
    );
  }
}
