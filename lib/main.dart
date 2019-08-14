import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:picturie/src/ui/camera_view/camera_view.dart';

Future<void> main() async {
  final cameras = await availableCameras();
  final firstCamera = cameras.first;
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CameraView(camera: firstCamera),
    ),
  );
}
