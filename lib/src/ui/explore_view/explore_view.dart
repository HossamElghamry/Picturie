import 'package:flutter/material.dart';
import 'package:picturie/src/authentication_bloc.dart';
import 'package:picturie/src/common/picture_overview.dart';
import 'package:picturie/src/common/picturie_appbar.dart';
import 'package:provider/provider.dart';

class ExploreView extends StatefulWidget {
  @override
  _ExploreViewState createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    final AuthService _authService = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: PicturieAppbar(
        title: "Explore",
      ),
      body: StreamBuilder<List<String>>(
        stream: _authService.randomPosts$,
        builder: (context, snapshot) {
          if (!snapshot.hasData ||
              snapshot.data == [] ||
              snapshot.data.length == 0) {
            _authService.getRandomPosts();
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return RefreshIndicator(
            color: Colors.teal,
            onRefresh: () {
              return _authService.getRandomPosts();
            },
            child: Padding(
              padding: EdgeInsets.only(top: 5.0),
              child: GridView.builder(
                physics: AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return PictureOverview(imageUrl: snapshot.data[index]);
                },
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
