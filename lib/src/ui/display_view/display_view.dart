import 'dart:io';
import 'package:flutter/material.dart';
import 'package:picturie/src/authentication_bloc.dart';
import 'package:picturie/src/common/picturie_appbar.dart';
import 'package:picturie/src/common/picturie_loading_indicator.dart';
import 'package:picturie/src/global_bloc.dart';
import 'package:provider/provider.dart';

class DisplayPictureScreen extends StatefulWidget {
  final String _imagePath;

  DisplayPictureScreen({Key key, imagePath}) : _imagePath = imagePath;

  @override
  _DisplayPictureScreenState createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  GlobalKey<ScaffoldState> _postUploadScaffoldKey;

  @override
  void initState() {
    _postUploadScaffoldKey = GlobalKey<ScaffoldState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AuthService _authService = Provider.of<AuthService>(context);
    return Scaffold(
      appBar: PicturieAppbar(
        title: "Upload post",
      ),
      key: _postUploadScaffoldKey,
      body: StreamBuilder<bool>(
        stream: _authService.loading$,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          if (snapshot.data) {
            return PicturieLoadingIndicator(
              status: "Uploading Picturie ...",
            );
          }
          return Column(
            children: <Widget>[
              Flexible(
                flex: 2,
                child: Container(
                  height: double.infinity,
                  child: Center(
                    child: Image.file(
                      File(widget._imagePath),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.38,
                      height: 45,
                      child: RaisedButton(
                        elevation: 0,
                        shape: StadiumBorder(),
                        color: Colors.teal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Icon(
                              Icons.cloud_upload,
                              size: 29,
                            ),
                            Text(
                              "Upload",
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        onPressed: () async {
                          try {
                            String imageURL = await _authService
                                .uploadPicturiePost(widget._imagePath);
                            _authService.addPicturiePost(imageURL);
                            _authService.updateUser();
                            Navigator.of(_postUploadScaffoldKey.currentContext)
                                .pop();
                          } catch (e) {
                            _postUploadScaffoldKey.currentState.showSnackBar(
                              SnackBar(
                                content: Text(
                                    'There was an error uploading the image'),
                                backgroundColor: Colors.red,
                                duration: Duration(seconds: 3),
                              ),
                            );
                            _authService.cancelLoad();
                          }
                        },
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.38,
                      height: 45,
                      child: RaisedButton(
                        elevation: 0,
                        shape: StadiumBorder(),
                        color: Colors.red[700],
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Icon(
                              Icons.cancel,
                              size: 29,
                            ),
                            Text(
                              "Cancel ",
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        onPressed: () {
                          Navigator.of(_postUploadScaffoldKey.currentContext)
                              .pop();
                        },
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
