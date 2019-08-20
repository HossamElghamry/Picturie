import 'package:flutter/material.dart';
import 'package:picturie/src/authentication_bloc.dart';
import 'package:picturie/src/common/picturie_loading_indicator.dart';
import 'package:picturie/src/common/picturie_logo_text.dart';
import 'package:picturie/src/common/platforms.dart';
import 'package:picturie/src/common/sign_in_data.dart';
import 'package:picturie/src/ui/sign_in/widgets/divider_centeredtext.dart';
import 'package:picturie/src/ui/sign_in/widgets/email_field.dart';
import 'package:picturie/src/ui/sign_in/widgets/password_field.dart';
import 'package:picturie/src/ui/sign_in/widgets/sign_in_button.dart';
import 'package:picturie/src/ui/sign_in/widgets/sign_up_platform.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  GlobalKey<FormState> _signInFormKey;
  SignInData _signInData;
  GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  void initState() {
    _signInFormKey = GlobalKey<FormState>();
    _signInData = SignInData("", "");
    _scaffoldKey = GlobalKey<ScaffoldState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AuthService _authService = Provider.of<AuthService>(context);
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      body: StreamBuilder<bool>(
          stream: _authService.loading$,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container();
            }
            if (snapshot.data) {
              return PicturieLoadingIndicator(
                status: "Signing In",
              );
            }
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 30),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: PicturieTextLogo(
                        textSize: 50.0,
                      ),
                    ),
                    Flexible(
                      flex: 3,
                      child: Container(
                        child: Form(
                          key: _signInFormKey,
                          child: Column(
                            children: <Widget>[
                              Flexible(
                                flex: 1,
                                child: EmailFormField(
                                  signInData: _signInData,
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: PasswordFormField(
                                  signInData: _signInData,
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: SignInButton(
                                  data: _signInData,
                                  formKey: _signInFormKey,
                                  scaffoldKey: _scaffoldKey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: DividerCentereText(),
                    ),
                    Flexible(
                      flex: 4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          SignInPlatformButton(
                            platform: Platform.Picturie,
                            logoPath: 'assets/icons/picturie_logo_cam_only.png',
                          ),
                          // SignInPlatformButton(
                          //   platform: Platform.Facebook,
                          //   logoPath: 'assets/icons/facebook_icon.png',
                          // ),
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
            );
          }),
    );
  }
}
