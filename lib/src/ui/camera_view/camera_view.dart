import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:picturie/src/ui/camera_view/setting_fabs.dart';
import 'package:picturie/src/ui/display_view/display_view.dart';

class CameraView extends StatefulWidget {
  final CameraDescription camera;

  CameraView({
    Key key,
    @required this.camera,
  }) : super(key: key);

  @override
  _CameraViewState createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> with TickerProviderStateMixin {
  CameraController _cameraController;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        child: Stack(
          children: <Widget>[
            previewScreen(),
            Positioned(
              top: 30,
              bottom: 0,
              right: 0,
              left: MediaQuery.of(context).size.height * 0.4,
              child: SettingsFABS(),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.825,
              bottom: 0,
              right: 0,
              left: 0,
              child: captureButton(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget captureButton(context) {
    return Container(
      width: double.infinity,
      color: Colors.transparent,
      child: Center(
        child: FloatingActionButton(
          child: Center(
            child: Icon(
              Icons.camera_alt,
              color: Colors.white,
            ),
          ),
          elevation: 0.0,
          backgroundColor: Colors.teal,
          onPressed: () async {
            await _initializeControllerFuture;
            final path = join(
              (await getExternalStorageDirectory()).path,
              '${DateTime.now()}.png',
            );
            await _cameraController.takePicture(path);
            GallerySaver.saveImage(path);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(imagePath: path),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget previewScreen() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black,
      child: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_cameraController);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Future initializeCamera() async {
    _cameraController =
        CameraController(widget.camera, ResolutionPreset.ultraHigh);
    _initializeControllerFuture = _cameraController.initialize();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }
}
