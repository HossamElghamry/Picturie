import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:picturie/src/authentication_bloc.dart';
import 'package:picturie/src/common/picturie_loading_indicator.dart';
import 'package:picturie/src/ui/profile_photo_signup/widgets/confirm_button.dart';
import 'package:picturie/src/ui/profile_photo_signup/widgets/skip_button.dart';
import 'package:provider/provider.dart';

class ProfilePhotoSignUp extends StatefulWidget {
  @override
  _ProfilePhotoSignUpState createState() => _ProfilePhotoSignUpState();
}

class _ProfilePhotoSignUpState extends State<ProfilePhotoSignUp> {
  File _image;
  GlobalKey<ScaffoldState> _profileUploadScaffoldKey;

  @override
  void initState() {
    _profileUploadScaffoldKey = GlobalKey<ScaffoldState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AuthService _authService = Provider.of<AuthService>(context);

    return Scaffold(
      key: _profileUploadScaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text("Profile Picture Setup"),
        elevation: 0.0,
      ),
      body: StreamBuilder<bool>(
        stream: _authService.loading$,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          if (snapshot.data) {
            return PicturieLoadingIndicator(
              status: "Uploading Image ...",
            );
          }
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    getImage();
                  },
                  child: Container(
                    width: 300.0,
                    height: 300.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: _image == null
                            ? AssetImage("assets/icons/picturie_logo.png")
                            : FileImage(
                                _image,
                              ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ConfirmButton(
                        profileUploadScaffoldKey: _profileUploadScaffoldKey,
                        image: _image),
                    SkipButton(),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(
      () {
        _image = image;
      },
    );
  }
}
