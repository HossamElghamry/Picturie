import 'package:flutter/material.dart';
import 'package:picturie/src/authentication_bloc.dart';
import 'package:provider/provider.dart';

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService authService = Provider.of<AuthService>(context);
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          child: RaisedButton(
            shape: StadiumBorder(),
            color: Colors.teal,
            child: Text(
              "Sign Out",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            onPressed: () async {
              authService.signOut();
              // _authService.signOut();
            },
          ),
        ),
      ),
    );
  }
}
