import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:picturie/src/authentication_bloc.dart';
import 'package:picturie/src/global_bloc.dart';
import 'package:picturie/src/ui/camera_view/camera_view.dart';
import 'package:picturie/src/ui/sign_in/sign_in.dart';
import 'package:picturie/src/ui/sign_up/sign_up.dart';
import 'package:picturie/src/ui/tab_view/tab_view.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';

void main() {
  runApp(Picturie());
}

class Picturie extends StatefulWidget {
  @override
  _PicturieState createState() => _PicturieState();
}

class _PicturieState extends State<Picturie> {
  AuthService authService;
  @override
  void initState() {
    authService = AuthService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );

    return Provider<GlobalBloc>(
      builder: (context) {
        return GlobalBloc();
      },
      dispose: (context, bloc) {
        bloc.dispose();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Provider.value(
          value: authService,
          child: StreamBuilder<FirebaseUser>(
            stream: FirebaseAuth.instance.onAuthStateChanged,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else {
                if (snapshot.hasData) {
                  return HomeTabView();
                }
                return SignInScreen();
              }
            },
          ),
        ),
        theme: ThemeData(
          brightness: Brightness.dark,
          fontFamily: 'Alcubierre',
        ),
        darkTheme: ThemeData(
          fontFamily: 'Alcubierre',
          brightness: Brightness.dark,
        ),

        // CameraView(camera: firstCamera),
      ),
    );
  }
}
