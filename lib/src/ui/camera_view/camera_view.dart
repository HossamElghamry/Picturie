import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:picturie/src/ui/camera_view/setting_fabs.dart';
import 'package:picturie/src/ui/display_view/display_view.dart';

class CameraView extends StatefulWidget {
  final GlobalKey globalKey;

  CameraView({Key key, this.globalKey}) : super(key: key);

  @override
  CameraViewState createState() => CameraViewState();
}

class CameraViewState extends State<CameraView> {
  Future<List<CameraDescription>> cameras;
  Future<void> _test;
  CameraDescription firstCamera;
  CameraController _cameraController;

  @override
  void initState() {
    _test = initializeCamera();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black,
              child: FutureBuilder<void>(
                future: _test,
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
            ),
            Positioned(
              top: 30,
              bottom: 0,
              right: 0,
              left: MediaQuery.of(context).size.height * 0.4,
              child: SettingsFABS(),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> capturePhoto(context) async {
    final path = join(
      (await getTemporaryDirectory()).path,
      '${DateTime.now()}.png',
    );
    await _cameraController.takePicture(path);
    //GallerySaver.saveImage(path);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DisplayPictureScreen(imagePath: path),
      ),
    );
  }

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    _cameraController =
        CameraController(firstCamera, ResolutionPreset.ultraHigh);
    await _cameraController.initialize();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }
}
