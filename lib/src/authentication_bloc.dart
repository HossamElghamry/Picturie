import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class AuthService {
  FirebaseAuth _auth;
  Firestore _database;

  Observable<FirebaseUser> user;
  Observable<Map<String, dynamic>> profile;
  BehaviorSubject<bool> loading;

  AuthService() {
    _auth = FirebaseAuth.instance;
    _database = Firestore.instance;

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

  Future<FirebaseUser> picturieSignIn(String email, String password) async {
    loading.add(true);
    try {
      FirebaseUser user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      updateUser(user);
      print(user.email);
      loading.add(false);
      return user;
    } catch (e) {
      throw e;
    }
  }

  void updateUser(FirebaseUser newUser) async {
    DocumentReference ref = _database.collection('users').document(newUser.uid);

    return ref.setData(
      {
        'uid': newUser.uid,
        'email': newUser.email,
        'username': newUser.displayName,
        'likes': 0,
        'posts': 0
      },
      merge: true,
    );
  }

  void signOut() {
    _auth.signOut();
  }
}
