import 'package:flutter/material.dart';
import 'package:picturie/src/common/tabs.dart';
import 'package:picturie/src/global_bloc.dart';
import 'package:provider/provider.dart';

class HomeTabView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalBloc globalBloc = Provider.of<GlobalBloc>(context);

    return Scaffold(
      bottomNavigationBar: StreamBuilder<Object>(
          stream: globalBloc.currentTabView$,
          builder: (context, snapshot) {
            return BottomNavigationBar(
              currentIndex: snapshot.data,
              onTap: (index) {
                globalBloc.changeHomeTab(index);
              },
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle),
                  title: Text('Profile'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  title: Text('Search'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.select_all),
                  title: Text('Ranking'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  title: Text('Settings'),
                ),
              ],
            );
          }),
    );
  }
}

// class BottomBarItem extends StatefulWidget {
//   final HomeTab _tab;
//   final IconData _icon;
//   final String _title;

//   BottomBarItem({Key key, icon, title, tab})
//       : _tab = tab,
//         _icon = icon,
//         _title = title;

//   @override
//   _BottomBarItemState createState() => _BottomBarItemState();
// }

// class _BottomBarItemState extends State<BottomBarItem>
//     with SingleTickerProviderStateMixin {
//   AnimationController _animationController;
//   Animation _colorTween;

//   @override
//   void initState() {
//     _animationController = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 500),
//     );
//     _colorTween = ColorTween(begin: Colors.teal[400], end: Colors.white)
//         .animate(_animationController);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final GlobalBloc globalBloc = Provider.of<GlobalBloc>(context);
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
//       child: StreamBuilder<HomeTab>(
//           stream: globalBloc.currentTabView$,
//           builder: (context, snapshot) {
//             return GestureDetector(
//               onTap: () {
//                 globalBloc.changeHomeTab(widget._tab);
//                 if (_animationController.status == AnimationStatus.completed) {
//                   _animationController.reverse();
//                 } else {
//                   _animationController.forward();
//                 }
//               },
//               child: Container(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   mainAxisSize: MainAxisSize.min,
//                   children: <Widget>[
//                     AnimatedBuilder(
//                       animation: _colorTween,
//                       builder: (context, child) {
//                         return Icon(widget._icon,
//                             size: 32,
//                             color: (snapshot.data == widget._tab)
//                                 ? _colorTween.value
//                                 : Colors.white);
//                       },
//                     ),
//                     AnimatedBuilder(
//                       animation: _colorTween,
//                       builder: (context, child) {
//                         return Text(
//                           widget._title,
//                           style: TextStyle(
//                               fontSize: 12,
//                               color: (snapshot.data == widget._tab)
//                                   ? _colorTween.value
//                                   : Colors.white),
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }),
//     );
//   }
// }
