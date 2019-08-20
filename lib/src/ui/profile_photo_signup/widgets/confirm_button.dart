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
      width: MediaQuery.of(context).size.width * 0.4,
      child: RaisedButton(
        shape: StadiumBorder(),
        color: Colors.teal,
        child: Text(
          "Confirm",
          style: TextStyle(fontSize: 18),
        ),
        onPressed: () async {
          if (_image == null) {
            _profileUploadScaffoldKey.currentState.showSnackBar(
              SnackBar(
                content: Text('Please select an image to upload'),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 3),
                action: SnackBarAction(
                  label: "Tap to Hide",
                  textColor: Colors.black,
                  onPressed: () {
                    Scaffold.of(context).hideCurrentSnackBar();
                  },
                ),
              ),
            );
          } else {
            try {
              String imageURL = await _authService.uploadProfilePicture(_image);
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
