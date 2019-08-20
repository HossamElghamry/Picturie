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

  BehaviorSubject<String> _uid$;
  BehaviorSubject<String> get uid => _uid$;

  BehaviorSubject<PicturieUser> _picturieProfile$;
  BehaviorSubject<PicturieUser> get picturieProfile$ => _picturieProfile$;

  BehaviorSubject<String> _profilePicturUrl$;
  BehaviorSubject<String> get username$ => _profilePicturUrl$;

  BehaviorSubject<int> _likes$;
  BehaviorSubject<int> get likes$ => _likes$;

  BehaviorSubject<int> _numberOfPicturies$;
  BehaviorSubject<int> get numberOfPicturies$ => _numberOfPicturies$;

  BehaviorSubject<bool> _loading$;
  BehaviorSubject<bool> get loading$ => _loading$;

  AuthService() {
    _auth = FirebaseAuth.instance;
    _database = Firestore.instance;
    _googleSignIn = GoogleSignIn();

    _picturieProfile$ = BehaviorSubject<PicturieUser>();
    _likes$ = BehaviorSubject<int>();
    _numberOfPicturies$ = BehaviorSubject<int>();
    _profilePicturUrl$ = BehaviorSubject<String>();
    _uid$ = BehaviorSubject<String>();

    _user$ = Observable(_auth.onAuthStateChanged);
    _user$.listen(
      (currentUser) {
        if (currentUser != null) {
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
    _profilePicturUrl$.sink.add(url);
  }

  void setNumberOfPicturies(int numberOfPicturies) {
    _numberOfPicturies$.sink.add(numberOfPicturies);
  }

  void addUserId(String uid) {
    _uid$.sink.add(uid);
  }

  String getCurrentUserId() {
    return _uid$.value;
  }

  void updateUser() async {
    DocumentReference ref =
        _database.collection('users').document(getCurrentUserId());
    int _likes = _likes$.value;
    int _numberOfPicturies = _numberOfPicturies$.value;
    String _profilePictureUrl = _profilePicturUrl$.value;

    ref.setData(
      {
        'profilePictureUrl': _profilePictureUrl,
        'likes': _likes,
        'numberOfPicturies': _numberOfPicturies,
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
        'numberOfPicturies': 0,
      },
    );
    setLikes(0);
    setNumberOfPicturies(0);
  }

  Future retrieveUserData() async {
    var ref = _database
        .collection('users')
        .where('uid', isEqualTo: getCurrentUserId())
        .limit(1);
    int likes = await ref
        .getDocuments()
        .then((data) => data.documents[0].data['likes']);
    int numberOfPicturies = await ref
        .getDocuments()
        .then((data) => data.documents[0].data['numberOfPicturies']);
    String profilePhotoUrl = await ref
        .getDocuments()
        .then((data) => data.documents[0].data['profilePictureUrl']);

    setLikes(likes);
    setNumberOfPicturies(numberOfPicturies);
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
    addUserId(user.uid);
    signUpUser(user, data.username);
    _loading$.add(false);
    return user;
  }

  Future<FirebaseUser> picturieSignIn(String email, String password) async {
    _loading$.add(true);
    FirebaseUser user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    addUserId(user.uid);
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
    addUserId(user.uid);
    retrieveUserData();
    _loading$.add(false);
    return user;
  }

  Future<String> uploadProfilePicture(File image) async {
    _loading$.add(true);
    String fileName = basename(image.path);
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(image);
    StorageTaskSnapshot downloadURL = await uploadTask.onComplete;
    final String imageURL = await downloadURL.ref.getDownloadURL();
    _loading$.add(false);
    return imageURL;
  }

  void dispose() {
    _picturieProfile$.close();
    _numberOfPicturies$.close();
    _likes$.close();
    _profilePicturUrl$.close();
    _loading$.close();
    _uid$.close();
  }
}
