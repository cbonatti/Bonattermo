import 'package:flutter/material.dart';

class WonGameDialogBox extends StatelessWidget {
  const WonGameDialogBox(this.word, this.trys) : super();
  final String word;
  final int trys;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Parabéns",
          style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
              fontSize: 40.0)),
      content: RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
                text: "Você acertou a palavra ",
                style: TextStyle(color: Colors.green, fontSize: 20.0)),
            TextSpan(
                text: word,
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold)),
            TextSpan(
                text: " em ",
                style: TextStyle(color: Colors.green, fontSize: 20.0)),
            TextSpan(
                text: trys.toString(),
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold)),
            TextSpan(
                text: " tentativas",
                style: TextStyle(color: Colors.green, fontSize: 20.0)),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Fechar'),
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}
