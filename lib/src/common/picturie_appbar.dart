import 'package:flutter/material.dart';

class PicturieAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String _title;

  PicturieAppbar({Key key, title}) : _title = title;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(_title),
    );
  }

  @override
  Size get preferredSize => Size(10, 50);
}
