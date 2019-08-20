import 'package:flutter/material.dart';
import 'package:picturie/src/authentication_bloc.dart';
import 'package:picturie/src/common/picturie_loading_indicator.dart';
import 'package:picturie/src/common/sign_up_data.dart';
import 'package:picturie/src/ui/sign_up/widgets/profile_picture_button.dart';
import 'package:picturie/src/ui/sign_up/widgets/signup_button.dart';
import 'package:picturie/src/ui/sign_up/widgets/signup_email_field.dart';
import 'package:picturie/src/ui/sign_up/widgets/signup_password_field.dart';
import 'package:picturie/src/ui/sign_up/widgets/signup_username_field.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  GlobalKey<FormState> _signUpFormKey;
  SignUpData _signUpData;
  GlobalKey<ScaffoldState> _signUpScaffoldKey;
  @override
  void initState() {
    _signUpData = SignUpData();
    _signUpFormKey = GlobalKey<FormState>();
    _signUpScaffoldKey = GlobalKey<ScaffoldState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AuthService _authService = Provider.of<AuthService>(context);

    return Scaffold(
        key: _signUpScaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: StreamBuilder<bool>(
            stream: _authService.loading,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container();
              }
              if (snapshot.data) {
                return PicturieLoadingIndicator(
                  status: "Signing Up",
                );
              }
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  child: Form(
                    key: _signUpFormKey,
                    child: Column(
                      children: <Widget>[
                        Flexible(
                          flex: 2,
                          child: ProfilePictureButton(),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Flexible(
                          flex: 1,
                          child: SignUpUsernameField(
                            data: _signUpData,
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: SignUpEmailField(
                            data: _signUpData,
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: SignUpPasswordField(
                            data: _signUpData,
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: SignUpSubmitButton(
                            signUpScaffoldKey: _signUpScaffoldKey,
                            formKey: _signUpFormKey,
                            data: _signUpData,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }));
  }
}
