import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

class PicturieLoadingIndicator extends StatelessWidget {
  final String _status;

  PicturieLoadingIndicator({Key key, status}) : _status = status;

  @override
  Widget build(BuildContext context) {
    if (_status == null) {
      return Center(
        child: FlareActor(
          "assets/animations/loading_indicator.flr",
          fit: BoxFit.contain,
          animation: "Load",
        ),
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Flexible(
          flex: 1,
          child: SizedBox(
            height: double.infinity,
          ),
        ),
        Flexible(
          flex: 3,
          child: Container(
            child: FlareActor(
              "assets/animations/loading_indicator.flr",
              fit: BoxFit.contain,
              animation: "Load",
            ),
          ),
        ),
        Flexible(
          flex: 2,
          child: Container(
            child: Center(
              child: Text(
                _status,
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
