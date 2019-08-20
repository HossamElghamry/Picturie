import 'package:flutter/material.dart';
import 'package:picturie/src/authentication_bloc.dart';
import 'package:picturie/src/models/picturie_user.dart';
import 'package:provider/provider.dart';

class PostStats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService _authService = Provider.of<AuthService>(context);

    return Container(
      height: double.infinity,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Container(
              width: double.infinity,
              child: StreamBuilder<PicturieUser>(
                  stream: _authService.picturieProfile$,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Container();
                    }
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Picturies",
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          snapshot.data.numberOfPicturies.toString(),
                          style: TextStyle(fontSize: 17),
                        )
                      ],
                    );
                  }),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              height: 40,
              width: 1,
              color: Color(0xFF64FFDA),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              width: double.infinity,
              child: StreamBuilder<PicturieUser>(
                stream: _authService.picturieProfile$,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container();
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Likes",
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        snapshot.data.likes.toString(),
                        style: TextStyle(fontSize: 17),
                      ),
                    ],
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
