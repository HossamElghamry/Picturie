import 'package:flutter/material.dart';
import 'package:picturie/src/global_bloc.dart';
import 'package:provider/provider.dart';

class BottomBarItem extends StatelessWidget {
  final int _index;
  final IconData _icon;
  final String _title;
  final PageController _pageController;

  BottomBarItem({Key key, index, icon, title, pageController})
      : _index = index,
        _icon = icon,
        _title = title,
        _pageController = pageController;

  @override
  Widget build(BuildContext context) {
    final GlobalBloc globalBloc = Provider.of<GlobalBloc>(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: StreamBuilder<int>(
          stream: globalBloc.currentTabView$,
          builder: (context, snapshot) {
            return GestureDetector(
              onTap: () {
                globalBloc.changeHomeTab(_index);
                _pageController.jumpToPage(_index);
              },
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      _icon,
                      size: snapshot.data == _index ? 32 : 30,
                      color: snapshot.data == _index
                          ? Color(0xFF64FFDA)
                          : Colors.white,
                    ),
                    snapshot.data == _index
                        ? Text(
                            _title,
                            style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF64FFDA),
                                fontWeight: FontWeight.w500),
                          )
                        : Container(),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
