import 'package:flutter/material.dart';
import 'package:picturie/src/authentication_bloc.dart';
import 'package:picturie/src/common/picturie_appbar.dart';
import 'package:picturie/src/models/post.dart';
import 'package:provider/provider.dart';

class ViewPost extends StatefulWidget {
  final String _imageUrl;

  ViewPost({Key key, imageUrl}) : _imageUrl = imageUrl;

  @override
  _ViewPostState createState() => _ViewPostState();
}

class _ViewPostState extends State<ViewPost> {
  @override
  Widget build(BuildContext context) {
    final AuthService _authService = Provider.of<AuthService>(context);
    return Scaffold(
      appBar: PicturieAppbar(
        title: "Image preview",
      ),
      body: FutureBuilder<Post>(
        future: _authService.getPicturiePost(widget._imageUrl),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data == null) {
            return (Center(
              child: CircularProgressIndicator(),
            ));
          }
          return Column(
            children: <Widget>[
              Flexible(
                flex: 3,
                child: GestureDetector(
                  onDoubleTap: () async {
                    _authService.likePost(
                      snapshot.data.pictureUrl,
                      snapshot.data.profileUid,
                    );
                    _authService.retrieveUserData();
                    setState(() {});
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Picturie liked!"),
                        backgroundColor: Colors.teal,
                        duration: Duration(
                          seconds: 2,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(
                      snapshot.data.pictureUrl,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.only(top: 30.0),
                  child: Container(
                    child: Text(
                      "Likes \n" + snapshot.data.likes.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 28),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
