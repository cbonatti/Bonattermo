import 'package:flutter/material.dart';

class ActionButton {
  static Widget create(BuildContext context, Widget child, IconData icon) {
    return GestureDetector(
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
    );
  }
}
