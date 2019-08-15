import 'package:flutter/material.dart';
import 'package:picturie/src/common/tabs.dart';
import 'package:picturie/src/global_bloc.dart';
import 'package:provider/provider.dart';

class HomeTabView extends StatefulWidget {
  @override
  _HomeTabViewState createState() => _HomeTabViewState();
}

class _HomeTabViewState extends State<HomeTabView> {
  PageController _pageController;
  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalBloc globalBloc = Provider.of<GlobalBloc>(context);

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.camera,
        ),
        onPressed: () {},
        elevation: 6.0,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          globalBloc.changeHomeTab(index);
        },
        children: <Widget>[
          Container(
            color: Colors.white,
          ),
          Container(
            color: Colors.black,
          ),
          Container(
            color: Colors.green,
          ),
          Container(
            color: Colors.black,
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            BottomBarItem(
              index: 0,
              icon: Icons.account_circle,
              title: "Profile",
              pageController: _pageController,
            ),
            Padding(
              padding: EdgeInsets.only(right: 18.0),
              child: BottomBarItem(
                index: 1,
                icon: Icons.search,
                title: "Search",
                pageController: _pageController,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: BottomBarItem(
                index: 2,
                icon: Icons.cloud_upload,
                title: "Ranking",
                pageController: _pageController,
              ),
            ),
            BottomBarItem(
              index: 3,
              icon: Icons.settings,
              title: "Settings",
              pageController: _pageController,
            ),
          ],
        ),
        shape: CircularNotchedRectangle(),
      ),
    );
  }
}

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
