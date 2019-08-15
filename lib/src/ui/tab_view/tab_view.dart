import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:picturie/src/global_bloc.dart';
import 'package:picturie/src/ui/camera_view/camera_view.dart';
import 'package:picturie/src/ui/display_view/display_view.dart';
import 'package:picturie/src/ui/profile_view/profile_view.dart';
import 'package:picturie/src/ui/tab_view/bottom_bar_item.dart';
import 'package:provider/provider.dart';

class HomeTabView extends StatefulWidget {
  @override
  _HomeTabViewState createState() => _HomeTabViewState();
}

class _HomeTabViewState extends State<HomeTabView> {
  PageController _pageController;
  GlobalKey<CameraViewState> globalKey;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    globalKey = GlobalKey();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalBloc globalBloc = Provider.of<GlobalBloc>(context);

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: StreamBuilder<int>(
          stream: globalBloc.currentTabView$,
          builder: (context, snapshot) {
            return FloatingActionButton(
              heroTag: null,
              backgroundColor: snapshot.data == 2
                  ? Theme.of(context).floatingActionButtonTheme.backgroundColor
                  : Colors.white,
              child: Icon(
                snapshot.data == 2 ? Icons.camera_alt : Icons.camera,
              ),
              onPressed: () async {
                if (snapshot.data != 2) {
                  _pageController.jumpToPage(2);
                } else {
                  globalKey.currentState.capturePhoto(context);
                }
              },
              elevation: 6.0,
            );
          }),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          globalBloc.changeHomeTab(index);
        },
        children: <Widget>[
          ProfileView(),
          Container(
            color: Colors.black,
          ),
          CameraView(key: globalKey),
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
                index: 3,
                icon: Icons.cloud_upload,
                title: "Ranking",
                pageController: _pageController,
              ),
            ),
            BottomBarItem(
              index: 4,
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
