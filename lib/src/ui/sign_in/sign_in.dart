import 'package:flutter/material.dart';
import 'package:picturie/src/authentication_bloc.dart';
import 'package:picturie/src/common/platforms.dart';
import 'package:picturie/src/ui/sign_in/widgets/divider_centeredtext.dart';
import 'package:picturie/src/ui/sign_in/widgets/email_field.dart';
import 'package:picturie/src/ui/sign_in/widgets/password_field.dart';
import 'package:picturie/src/ui/sign_in/widgets/picturie_logo.dart';
import 'package:picturie/src/ui/sign_in/widgets/sign_in_alternative.dart';
import 'package:picturie/src/ui/sign_in/widgets/sign_in_button.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _emailController;
  TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 30),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: PicturieLogo(),
              ),
              Flexible(
                flex: 1,
                child: EmailFormField(controller: _emailController),
              ),
              Flexible(
                flex: 1,
                child: PasswordFormField(controller: _passwordController),
              ),
              Flexible(
                flex: 1,
                child: SignInButton(
                    emailController: _emailController,
                    passwordController: _passwordController),
              ),
              Flexible(
                flex: 1,
                child: DividerCentereText(),
              ),
              Flexible(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SignInPlatformButton(
                      platform: Platform.Picturie,
                      logoPath: 'assets/icons/facebook_icon.png',
                    ),
                    SignInPlatformButton(
                      platform: Platform.Facebook,
                      logoPath: 'assets/icons/facebook_icon.png',
                    ),
                    SignInPlatformButton(
                      platform: Platform.Google,
                      logoPath: 'assets/icons/google_icon.png',
                    ),
                    SignInPlatformButton(
                      platform: Platform.Outlook,
                      logoPath: 'assets/icons/outlook_icon.png',
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
