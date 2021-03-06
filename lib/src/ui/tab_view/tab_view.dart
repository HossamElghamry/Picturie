import 'package:flutter/material.dart';
import 'package:picturie/src/global_bloc.dart';
import 'package:picturie/src/ui/camera_view/camera_view.dart';
import 'package:picturie/src/ui/explore_view/explore_view.dart';
import 'package:picturie/src/ui/profile_view/profile_view.dart';
import 'package:picturie/src/ui/settings_view/settings.dart';
import 'package:picturie/src/ui/tab_view/bottom_bar_item.dart';
import 'package:provider/provider.dart';

class HomeTabView extends StatefulWidget {
  @override
  _HomeTabViewState createState() => _HomeTabViewState();
}

class _HomeTabViewState extends State<HomeTabView>
    with AutomaticKeepAliveClientMixin {
  PageController _pageController;
  GlobalKey<CameraViewState> globalKey;

  @override
  void initState() {
    _pageController = PageController();
    globalKey = GlobalKey();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
              print(snapshot.data);
              if (snapshot.data != 2) {
                _pageController.jumpToPage(2);
              } else {
                globalKey.currentState.capturePhoto(context);
              }
            },
            elevation: 6.0,
          );
        },
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          globalBloc.changeHomeTab(index);
        },
        children: <Widget>[
          ProfileView(),
          ExploreView(),
          CameraView(key: globalKey),
          SettingsView(),
          SettingsView()
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
                title: "Explore",
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

  @override
  bool get wantKeepAlive => true;
}
