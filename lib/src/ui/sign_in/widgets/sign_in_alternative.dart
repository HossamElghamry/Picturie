import 'package:flutter/material.dart';

class SignInPlatformButton extends StatelessWidget {
  final String _logoPath;

  SignInPlatformButton({Key key, logoPath}) : _logoPath = logoPath;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: null,
      backgroundColor: Colors.teal,
      onPressed: () {},
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
