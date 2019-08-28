import 'dart:io';

import 'package:flutter/material.dart';
import 'package:picturie/src/authentication_bloc.dart';
import 'package:provider/provider.dart';

class ConfirmButton extends StatelessWidget {
  final File _image;
  final GlobalKey<ScaffoldState> _profileUploadScaffoldKey;

  ConfirmButton({Key key, image, profileUploadScaffoldKey})
      : _image = image,
        _profileUploadScaffoldKey = profileUploadScaffoldKey;

  @override
  Widget build(BuildContext context) {
    final AuthService _authService = Provider.of<AuthService>(context);
    return Container(
      width: MediaQuery.of(context).size.width * 0.38,
      height: 45,
      child: RaisedButton(
        elevation: 0,
        shape: StadiumBorder(),
        color: Colors.teal,
        child: Row(
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Icon(
                Icons.file_upload,
                size: 34,
              ),
            ),
            Text(
              " UPLOAD",
              style: TextStyle(fontSize: 22),
            ),
          ],
        ),
        onPressed: () async {
          if (_image == null) {
            _profileUploadScaffoldKey.currentState.showSnackBar(
              SnackBar(
                content:
                    Text('Please select an image by tapping the picturie icon'),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 3),
                action: SnackBarAction(
                  label: "Tap to Hide",
                  textColor: Colors.black,
                  onPressed: () {
                    _profileUploadScaffoldKey.currentState
                        .hideCurrentSnackBar();
                  },
                ),
              ),
            );
          } else {
            try {
              String imageURL = await _authService.uploadProfilePicture(_image);
              _authService.setProfilePicture(imageURL);
              _authService.updateUser();
              Navigator.of(_profileUploadScaffoldKey.currentContext).pop();
            } catch (e) {
              _profileUploadScaffoldKey.currentState.showSnackBar(
                SnackBar(
                  content: Text('There was an error uploading the image'),
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 3),
                ),
              );
              _authService.cancelLoad();
            }
          }
        },
      ),
    );
  }
}
