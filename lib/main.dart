import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:picturie/src/global_bloc.dart';
import 'package:picturie/src/ui/camera_view/camera_view.dart';
import 'package:picturie/src/ui/tab_view/tab_view.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  final cameras = await availableCameras();
  final firstCamera = cameras.first;
  runApp(Picturie());
}

class Picturie extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<GlobalBloc>(
      builder: (context) {
        return GlobalBloc();
      },
      dispose: (context, bloc) {
        bloc.dispose();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeTabView(),
        theme: ThemeData.dark(),
        darkTheme:
            ThemeData(fontFamily: "Alcubierre", brightness: Brightness.dark),
        // CameraView(camera: firstCamera),
      ),
    );
  }
}
