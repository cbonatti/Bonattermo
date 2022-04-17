import 'package:flutter/material.dart';

import 'main.dart';

class LoseGameDialogBox extends StatelessWidget {
  const LoseGameDialogBox(this.word) : super();
  final String word;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Eita nóis",
          style: TextStyle(
              color: Colors.red, fontWeight: FontWeight.bold, fontSize: 30.0)),
      content: RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
                text: "Infelizmente não foi dessa vez!",
                style: TextStyle(color: Colors.black87, fontSize: 20.0)),
            TextSpan(
                text: "    A palavra era ",
                style: TextStyle(color: Colors.black87, fontSize: 20.0)),
            TextSpan(
                text: word,
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Fechar'),
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyApp()),
            );
          },
        )
      ],
    );
  }
}
