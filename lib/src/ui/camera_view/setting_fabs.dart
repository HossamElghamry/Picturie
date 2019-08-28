import 'package:flutter/material.dart';

class SettingsFABS extends StatefulWidget {
  @override
  _SettingsFABSState createState() => _SettingsFABSState();
}

class _SettingsFABSState extends State<SettingsFABS>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  final List<IconData> _icons = [
    Icons.camera_alt,
    Icons.camera,
    Icons.camera_enhance,
    Icons.camera_rear
  ];

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(_icons.length, (int index) {
            Widget child;
            if (index == 0) {
              child = Container(
                height: 100.0,
                width: 60.0,
                child: FloatingActionButton(
                  heroTag: null,
                  child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (BuildContext context, Widget child) {
                      return Transform.rotate(
                        angle: _animationController.value,
                        child: Icon(Icons.settings),
                      );
                    },
                  ),
                  onPressed: () {
                    if (_animationController.isDismissed) {
                      _animationController.forward();
                    } else {
                      _animationController.reverse();
                    }
                  },
                ),
              );
            } else {
              child = Container(
                height: 80.0,
                width: 60.0,
                alignment: FractionalOffset.topCenter,
                child: ScaleTransition(
                  scale: CurvedAnimation(
                    parent: _animationController,
                    curve: Interval(
                      0.0,
                      1.0,
                      curve: Curves.easeOutCubic,
                    ),
                  ),
                  child: FloatingActionButton(
                    heroTag: null,
                    shape: StadiumBorder(),
                    child: Icon(_icons[index]),
                    onPressed: () {
                      if (_animationController.isDismissed) {
                        _animationController.forward();
                      } else {
                        _animationController.reverse();
                      }
                    },
                  ),
                ),
              );
            }
            return child;
          }).toList()),
    );
  }
}
