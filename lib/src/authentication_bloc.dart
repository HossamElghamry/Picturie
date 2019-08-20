import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:picturie/src/common/sign_up_data.dart';
import 'package:rxdart/rxdart.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  FirebaseAuth _auth;
  Firestore _database;
  GoogleSignIn _googleSignIn;

  Observable<FirebaseUser> user;
  Observable<Map<String, dynamic>> profile;
  BehaviorSubject<bool> loading;

  AuthService() {
    _auth = FirebaseAuth.instance;
    _database = Firestore.instance;
    _googleSignIn = GoogleSignIn();

    user = Observable(_auth.onAuthStateChanged);
    profile = user.switchMap((currentUser) {
      if (currentUser != null) {
        return _database
            .collection('users')
            .document(currentUser.uid)
            .snapshots()
            .map((snapshot) => snapshot.data);
      } else {
        return Observable.just(null);
      }
    });

    loading = BehaviorSubject.seeded(false);
  }

  Future<FirebaseUser> picturieSignUp(SignUpData data) async {
    loading.add(true);
    FirebaseUser user = await _auth.createUserWithEmailAndPassword(
        email: data.email, password: data.password);
    signUpUser(user, data);
    loading.add(false);
    return user;
  }

  Future<FirebaseUser> picturieSignIn(String email, String password) async {
    loading.add(true);
    FirebaseUser user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    updateUser(user);
    loading.add(false);
    return user;
  }

  Future<FirebaseUser> googleSignIn() async {
    loading.add(true);
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication userAuth =
        await googleSignInAccount.authentication;

    AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: userAuth.idToken, accessToken: userAuth.accessToken);
    FirebaseUser user = await _auth.signInWithCredential(credential);

    updateUser(user);
    loading.add(false);
    return user;
  }

  void updateUser(FirebaseUser user) async {
    DocumentReference ref = _database.collection('users').document(user.uid);

    return ref.setData(
      {
        'uid': user.uid,
        'email': user.email,
        'username': user.displayName,
        'likes': 0,
        'posts': 0
      },
      merge: true,
    );
  }

  void signUpUser(FirebaseUser newUser, SignUpData data) async {
    DocumentReference ref = _database.collection('users').document(newUser.uid);

    return ref.setData(
      {
        'uid': newUser.uid,
        'email': newUser.email,
        'username': data.username,
        'likes': 0,
        'posts': 0
      },
    );
  }

  void cancelLoad() {
    loading.add(false);
  }

  void signOut() {
    _auth.signOut();
  }
}
