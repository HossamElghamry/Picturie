import 'package:flutter/material.dart';

class PicturiePosts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12.0),
      child: Container(
        child: GridView.builder(
          physics: BouncingScrollPhysics(),
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount: 8,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                color: Color(0xFF64FFDA),
              ),
            );
          },
        ),
      ),
    );
  }
}
