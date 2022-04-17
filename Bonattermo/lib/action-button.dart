import 'package:flutter/material.dart';

class ActionButton {
  static Widget create(BuildContext context, Widget child, IconData icon) {
    return Padding(
      padding: EdgeInsets.only(right: 20.0),
      child: GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return child;
              });
        },
        child: Icon(
          icon,
          size: 26.0,
        ),
      ),
    );
  }
}
