import 'package:flutter/material.dart';
import 'package:picturie/src/common/view_post.dart';

class PictureOverview extends StatelessWidget {
  final String _imageUrl;

  PictureOverview({Key key, imageUrl}) : _imageUrl = imageUrl;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ViewPost(
              imageUrl: _imageUrl,
            ),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.all(2.0),
        child: Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 2),
          ),
          child: Image.network(
            _imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
