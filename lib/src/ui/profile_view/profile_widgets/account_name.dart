import 'package:flutter/material.dart';
import 'package:picturie/src/authentication_bloc.dart';
import 'package:picturie/src/models/picturie_user.dart';
import 'package:provider/provider.dart';

class AccountName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService _authService = Provider.of<AuthService>(context);
    return Padding(
      padding: EdgeInsets.only(top: 28.0),
      child: Container(
        height: double.infinity,
        child: StreamBuilder<PicturieUser>(
            stream: _authService.picturieProfile$,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container();
              }
              return Text(
                snapshot.data.username,
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                ),
              );
            }),
      ),
    );
  }
}
