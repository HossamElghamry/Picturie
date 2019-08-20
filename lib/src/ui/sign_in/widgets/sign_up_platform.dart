import 'package:flutter/material.dart';
import 'package:picturie/src/authentication_bloc.dart';
import 'package:picturie/src/common/platforms.dart';
import 'package:picturie/src/ui/sign_up/sign_up.dart';
import 'package:provider/provider.dart';

class SignInPlatformButton extends StatelessWidget {
  final Platform _platform;
  final String _logoPath;

  SignInPlatformButton({Key key, platform, logoPath})
      : _platform = platform,
        _logoPath = logoPath;

  @override
  Widget build(BuildContext context) {
    AuthService _authService = Provider.of<AuthService>(context);
    return FloatingActionButton(
      heroTag: null,
      backgroundColor: Colors.teal,
      hoverElevation: 5,
      elevation: 3,
      onPressed: () {
        switch (_platform) {
          case Platform.Picturie:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SignUpScreen(),
              ),
            );
            break;
          case Platform.Facebook:
            break;
          case Platform.Google:
            _authService.googleSignIn().catchError((error) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('Could not sign in using Google'),
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 3),
                  action: SnackBarAction(
                    label: "Ok",
                    onPressed: () {
                      Scaffold.of(context).hideCurrentSnackBar();
                    },
                  ),
                ),
              );
            });

            break;
          case Platform.Outlook:
            break;
        }
      },
      child: Container(
        width: _platform == Platform.Picturie ? 40 : 30,
        height: _platform == Platform.Picturie ? 40 : 30,
        child: Image.asset(
          _logoPath,
          color: Colors.white,
        ),
      ),
    );
  }
}
