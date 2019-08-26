import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String _profileUid;
  String _pictureUrl;
  int _likes;

  String get profileUid => _profileUid;
  String get pictureUrl => _pictureUrl;
  int get likes => _likes;

  Post(
    this._profileUid,
    this._pictureUrl,
    this._likes,
  );

  factory Post.fromDocument(DocumentSnapshot documentSnapshot) {
    if (documentSnapshot == null) {
      return null;
    }
    Map<dynamic, dynamic> data = documentSnapshot.data;
    return Post(
      data['profileUid'],
      data['pictureUrl'],
      data['likes'],
    );
  }
}
