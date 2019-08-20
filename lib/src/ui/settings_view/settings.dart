import 'package:flutter/material.dart';
import 'package:picturie/src/authentication_bloc.dart';
import 'package:picturie/src/common/picturie_loading_indicator.dart';
import 'package:provider/provider.dart';

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService _authService = Provider.of<AuthService>(context);
    return Scaffold(
      body: StreamBuilder<bool>(
          stream: _authService.loading$,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container();
            }
            if (snapshot.data) {
              return PicturieLoadingIndicator(
                status: "Signing Out",
              );
            }
            return Center(
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
                    _authService.signOut();
                    // _authService.signOut();
                  },
                ),
              ),
            );
          }),
    );
  }
}
