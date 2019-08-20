import 'package:cloud_firestore/cloud_firestore.dart';

class PicturieUser {
  String _uid;
  String _username;
  String _email;
  String _profilePictureUrl;
  int _likes;
  int _numberOfPicturies;

  String get uid => _uid;
  String get username => _username;
  String get email => _email;
  String get profilePictureUrl => _profilePictureUrl;
  int get likes => _likes;
  int get numberOfPicturies => _numberOfPicturies;

  PicturieUser(
    this._uid,
    this._username,
    this._email,
    this._profilePictureUrl,
    this._likes,
    this._numberOfPicturies,
  );

  factory PicturieUser.fromDocument(DocumentSnapshot documentSnapshot) {
    if (documentSnapshot == null) {
      return null;
    }
    Map<dynamic, dynamic> data = documentSnapshot.data;
    return PicturieUser(
      documentSnapshot.documentID,
      data['username'],
      data['email'],
      data['profilePictureUrl'],
      data['likes'],
      data['numberOfPicturies'],
    );
  }
}
