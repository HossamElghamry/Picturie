import 'package:flutter/material.dart';
import 'package:picturie/src/authentication_bloc.dart';
import 'package:provider/provider.dart';

class PictureAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService _authService = Provider.of<AuthService>(context);

    return StreamBuilder<String>(
      stream: _authService.profilePictureUrl$,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }
        return Container(
          width: 106.0,
          height: 110.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Color(0xFF64FFDA), width: 2),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: (snapshot.data == null || snapshot.data == '')
                  ? AssetImage("assets/icons/picturie_logo.png")
                  : NetworkImage(snapshot.data),
            ),
          ),
        );
      },
    );
  }
}
