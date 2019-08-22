import 'package:flutter/material.dart';
import 'package:picturie/src/ui/profile_view/profile_widgets/account_name.dart';
import 'package:picturie/src/ui/profile_view/profile_widgets/picture_avatar.dart';
import 'package:picturie/src/ui/profile_view/profile_widgets/post_stats.dart';
import 'package:picturie/src/ui/profile_view/profile_widgets/picturie_posts.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12, right: 12, top: 40),
      child: Container(
        height: double.infinity,
        child: Column(
          children: <Widget>[
            Flexible(
              flex: 2,
              child: PictureAvatar(),
            ),
            Flexible(
              flex: 2,
              child: AccountName(),
            ),
            Flexible(
              flex: 1,
              child: PostStats(),
            ),
            Flexible(
              flex: 8,
              child: PicturiePosts(),
            )
          ],
        ),
      ),
    );
  }

  bool get wantKeepAlive => true;
}
