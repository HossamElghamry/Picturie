import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart';
import 'package:picturie/src/common/sign_up_data.dart';
import 'package:picturie/src/models/picturie_user.dart';
import 'package:rxdart/rxdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthService {
  FirebaseAuth _auth;
  Firestore _database;
  GoogleSignIn _googleSignIn;

  Observable<FirebaseUser> _user$;
  Observable<FirebaseUser> get user$ => _user$;

  // BehaviorSubject<String> _uid$;
  // BehaviorSubject<String> get uid => _uid$;

  BehaviorSubject<PicturieUser> _picturieProfile$;
  BehaviorSubject<PicturieUser> get picturieProfile$ => _picturieProfile$;

  BehaviorSubject<String> _profilePictureUrl$;
  BehaviorSubject<String> get profilePictureUrl$ => _profilePictureUrl$;

  BehaviorSubject<int> _likes$;
  BehaviorSubject<int> get likes$ => _likes$;

  BehaviorSubject<List<dynamic>> _picturiePosts$;
  BehaviorSubject<List<dynamic>> get picturiePosts$ => _picturiePosts$;

  BehaviorSubject<bool> _loading$;
  BehaviorSubject<bool> get loading$ => _loading$;

  String userID;

  AuthService() {
    _auth = FirebaseAuth.instance;
    _database = Firestore.instance;
    _googleSignIn = GoogleSignIn();

    _picturieProfile$ = BehaviorSubject<PicturieUser>();
    _likes$ = BehaviorSubject<int>();
    _picturiePosts$ = BehaviorSubject<List<dynamic>>();
    _profilePictureUrl$ = BehaviorSubject<String>();
    // _uid$ = BehaviorSubject<String>();

    _user$ = Observable(_auth.onAuthStateChanged);
    _user$.listen(
      (currentUser) {
        if (currentUser != null) {
          userID = currentUser.uid;
          _database
              .collection('users')
              .document(currentUser.uid)
              .snapshots()
              .listen(
            (DocumentSnapshot documentSnapshot) {
              return _picturieProfile$.sink.add(
                PicturieUser.fromDocument(documentSnapshot),
              );
            },
          );
        } else {
          _picturieProfile$ = BehaviorSubject<PicturieUser>();
        }
      },
    );
    _loading$ = BehaviorSubject<bool>.seeded(false);
  }

  void setLikes(int likes) {
    _likes$.sink.add(likes);
  }

  void setProfilePicture(String url) {
    _profilePictureUrl$.sink.add(url);
  }

  void addPicturiePost(String imageUrl) {
    List<dynamic> tmp = List<dynamic>.from(_picturiePosts$.value);
    tmp.add(imageUrl);
    _picturiePosts$.sink.add(tmp);
  }

  void setPicturiePosts(List<dynamic> posts) {
    _picturiePosts$.sink.add(posts);
  }

  // void addUserId(String uid) {
  //   _uid$.sink.add(uid);
  // }

  // String getCurrentUserId() {
  //   return _uid$.value;
  // }

  void updateUser() async {
    DocumentReference ref = _database.collection('users').document(userID);
    int _likes = _likes$.value;
    List<dynamic> _picturiePosts = _picturiePosts$.value;
    String _profilePictureUrl = _profilePictureUrl$.value;

    ref.updateData(
      {
        'profilePictureUrl': _profilePictureUrl,
        'likes': _likes,
        'picturiePosts': _picturiePosts,
      },
    );
    ref.snapshots().listen(
      (DocumentSnapshot snapshot) {
        return _picturieProfile$.sink.add(
          PicturieUser.fromDocument(snapshot),
        );
      },
    );
  }

  void signUpUser(FirebaseUser newUser, String username) async {
    DocumentReference ref = _database.collection('users').document(newUser.uid);
    ref.setData(
      {
        'uid': newUser.uid,
        'username': username,
        'email': newUser.email,
        'profilePictureUrl': "",
        'likes': 0,
        'picturiePosts': [],
      },
    );
    setLikes(0);
    setPicturiePosts([]);
  }

  Future retrieveUserData() async {
    var ref =
        _database.collection('users').where('uid', isEqualTo: userID).limit(1);
    int likes = await ref
        .getDocuments()
        .then((data) => data.documents[0].data['likes']);
    List<dynamic> picturiePosts = await ref
        .getDocuments()
        .then((data) => data.documents[0].data['picturiePosts']);
    String profilePhotoUrl = await ref
        .getDocuments()
        .then((data) => data.documents[0].data['profilePictureUrl']);

    setLikes(likes);
    setPicturiePosts(picturiePosts);
    setProfilePicture(profilePhotoUrl);
  }

  void cancelLoad() {
    _loading$.add(false);
  }

  void signOut() {
    _auth.signOut();
  }

  Future<FirebaseUser> picturieSignUp(SignUpData data) async {
    _loading$.add(true);
    FirebaseUser user = await _auth.createUserWithEmailAndPassword(
        email: data.email, password: data.password);
    userID = user.uid;
    signUpUser(user, data.username);
    _loading$.add(false);
    return user;
  }

  Future<FirebaseUser> picturieSignIn(String email, String password) async {
    _loading$.add(true);
    FirebaseUser user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    userID = user.uid;
    retrieveUserData();
    _loading$.add(false);
    return user;
  }

  Future<FirebaseUser> googleSignIn() async {
    _loading$.add(true);
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication userAuth =
        await googleSignInAccount.authentication;

    AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: userAuth.idToken, accessToken: userAuth.accessToken);
    FirebaseUser user = await _auth.signInWithCredential(credential);
    userID = user.uid;
    retrieveUserData();
    _loading$.add(false);
    return user;
  }

  Future<String> uploadProfilePicture(File image) async {
    _loading$.add(true);
    String fileName = basename(image.path);
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child("profile_pictures/" + fileName);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(image);
    StorageTaskSnapshot downloadURL = await uploadTask.onComplete;
    final String imageURL = await downloadURL.ref.getDownloadURL();
    _loading$.add(false);
    return imageURL;
  }

  Future<String> uploadPicturiePost(String path) async {
    _loading$.add(true);
    String fileName = basename(path);
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child("picturie_posts/" + fileName);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(File(path));
    StorageTaskSnapshot downloadURL = await uploadTask.onComplete;
    final String imageURL = await downloadURL.ref.getDownloadURL();
    _loading$.add(false);
    return imageURL;
  }

  void dispose() {
    _picturieProfile$.close();
    _picturiePosts$.close();
    _likes$.close();
    _profilePictureUrl$.close();
    _loading$.close();
    // _uid$.close();
  }
}
