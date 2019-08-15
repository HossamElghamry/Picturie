import 'package:flutter/material.dart';

class AccountName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
