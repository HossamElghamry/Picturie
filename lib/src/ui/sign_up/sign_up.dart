import 'package:flutter/material.dart';
import 'package:picturie/src/ui/sign_up/widgets/profile_picture_button.dart';
import 'package:picturie/src/ui/sign_up/widgets/signup_button.dart';
import 'package:picturie/src/ui/sign_up/widgets/signup_email_field.dart';
import 'package:picturie/src/ui/sign_up/widgets/signup_password_field.dart';
import 'package:picturie/src/ui/sign_up/widgets/signup_username_field.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          child: Column(
            children: <Widget>[
              Flexible(
                flex: 2,
                child: ProfilePictureButton(),
              ),
              Flexible(
                flex: 1,
                child: SignUpUsernameField(),
              ),
              Flexible(
                flex: 1,
                child: SignUpEmailField(),
              ),
              Flexible(
                flex: 1,
                child: SignUpPasswordField(),
              ),
              Flexible(
                flex: 2,
                child: SignUpSubmitButton(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
