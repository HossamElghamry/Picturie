import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:picturie/src/authentication_bloc.dart';
import 'package:picturie/src/common/picturie_loading_indicator.dart';
import 'package:picturie/src/global_bloc.dart';
import 'package:picturie/src/ui/camera_view/camera_view.dart';
import 'package:picturie/src/ui/sign_in/sign_in.dart';
import 'package:picturie/src/ui/tab_view/tab_view.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(Picturie());
}

class Picturie extends StatefulWidget {
  @override
  _PicturieState createState() => _PicturieState();
}

class _PicturieState extends State<Picturie> {
  AuthService authService;
  GlobalBloc globalBloc;
  @override
  void initState() {
    authService = AuthService();
    globalBloc = GlobalBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );

    return MultiProvider(
      providers: [
        Provider.value(
          value: authService,
        ),
        Provider.value(
          value: globalBloc,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StreamBuilder<FirebaseUser>(
          stream: authService.user$,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(
                body: PicturieLoadingIndicator(),
              );
            } else {
              if (snapshot.hasData) {
                return HomeTabView();
              }
              // authService.signOut();
              return SignInScreen();
            }
          },
        ),
        theme: ThemeData(
          brightness: Brightness.dark,
          fontFamily: 'Alcubierre',
        ),
        darkTheme: ThemeData(
          fontFamily: 'Alcubierre',
          brightness: Brightness.dark,
        ),
      ),
    );
  }
}
