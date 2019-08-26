import 'package:flutter/material.dart';
import 'package:picturie/src/authentication_bloc.dart';
import 'package:picturie/src/common/picture_overview.dart';
import 'package:picturie/src/common/view_post.dart';
import 'package:provider/provider.dart';

class PicturiePosts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService _authService = Provider.of<AuthService>(context);

    return StreamBuilder<List<dynamic>>(
      stream: _authService.picturiePosts$,
      builder: (context, snapshot) {
        if (snapshot.data == [] ||
            snapshot.data == null ||
            snapshot.data.length == 0) {
          _authService.retrieveUserData();
          return Container(
            height: double.infinity,
            child: Center(
              child: Text(
                "Take some picturies :)",
                style: TextStyle(fontSize: 28, color: Colors.white),
              ),
            ),
          );
        }
        return Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: Container(
            child: GridView.builder(
              physics: BouncingScrollPhysics(),
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return PictureOverview(imageUrl: snapshot.data[index]);
              },
            ),
          ),
        );
      },
    );
  }
}
