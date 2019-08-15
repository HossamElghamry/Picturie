import 'package:flutter/material.dart';
import 'package:picturie/src/common/platforms.dart';
import 'package:picturie/src/ui/sign_up/sign_up.dart';

class SignInPlatformButton extends StatelessWidget {
  final Platform _platform;
  final String _logoPath;

  SignInPlatformButton({Key key, platform, logoPath})
      : _platform = platform,
        _logoPath = logoPath;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: null,
      backgroundColor: Colors.teal,
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
            break;
          case Platform.Outlook:
            break;
        }
      },
      child: Container(
        width: 30,
        height: 30,
        child: Image.asset(
          _logoPath,
          color: Colors.white,
        ),
      ),
    );
  }
}
