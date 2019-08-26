import 'package:flutter/material.dart';
import 'package:picturie/src/authentication_bloc.dart';
import 'package:picturie/src/common/picture_overview.dart';
import 'package:provider/provider.dart';

class PicturiePosts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService _authService = Provider.of<AuthService>(context);

    return StreamBuilder<List<dynamic>>(
      stream: _authService.picturiePosts$,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          _authService.retrieveUserData();
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.data == [] || snapshot.data.length == 0) {
          return Center(
            child: Column(
              children: <Widget>[
                Icon(Icons.picture_in_picture),
                Text(
                  "Take some picturies",
                  style: TextStyle(fontSize: 28),
                ),
              ],
            ),
          );
        }
        return Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: Container(
            child: GridView.builder(
              physics: AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
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
