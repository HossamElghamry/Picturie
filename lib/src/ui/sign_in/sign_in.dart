import 'package:flutter/material.dart';
import 'package:picturie/src/common/platforms.dart';
import 'package:picturie/src/ui/sign_in/widgets/divider_centeredtext.dart';
import 'package:picturie/src/ui/sign_in/widgets/email_field.dart';
import 'package:picturie/src/ui/sign_in/widgets/password_field.dart';
import 'package:picturie/src/ui/sign_in/widgets/picturie_logo.dart';
import 'package:picturie/src/ui/sign_in/widgets/sign_in_alternative.dart';
import 'package:picturie/src/ui/sign_in/widgets/sign_in_button.dart';

class SignInScreen extends StatelessWidget {
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
                child: EmailFormField(),
              ),
              Flexible(
                flex: 1,
                child: PasswordFormField(),
              ),
              Flexible(
                flex: 1,
                child: SignInButton(),
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
}
