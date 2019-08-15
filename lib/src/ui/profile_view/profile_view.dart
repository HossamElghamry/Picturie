import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12, right: 12, top: 40),
      child: Container(
        height: double.infinity,
        child: Column(
          children: <Widget>[
            Flexible(
              flex: 2,
              child: Container(
                height: double.infinity,
                child: CircleAvatar(
                  radius: 50,
                  child: Icon(
                    Icons.person,
                    size: 50,
                  ),
                  backgroundColor: Color(0xFF64FFDA),
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.only(top: 28.0),
                child: Container(
                  height: double.infinity,
                  child: Text(
                    "Hossam Elghamry",
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                height: double.infinity,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Container(
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Picturies",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "12",
                              style: TextStyle(fontSize: 17),
                            )
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        height: 40,
                        width: 1,
                        color: Color(0xFF64FFDA),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Likes",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "205",
                              style: TextStyle(fontSize: 17),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 8,
              child: Padding(
                padding: EdgeInsets.only(top: 12.0),
                child: Container(
                  child: GridView.builder(
                    physics: BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                          color: Color(0xFF64FFDA),
                        ),
                      );
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
