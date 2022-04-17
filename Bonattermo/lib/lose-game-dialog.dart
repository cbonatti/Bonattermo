import 'package:flutter/material.dart';

import 'main.dart';

class LoseGameDialogBox extends StatelessWidget {
  const LoseGameDialogBox(this.word) : super();
  final String word;

  @override
  Widget build(BuildContext context) {
    Widget _title() {
      return Text(
        "Eita nóis",
        style: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
          fontSize: 30.0,
        ),
      );
    }

    TextSpan _normalWord(String word) {
      return TextSpan(
        text: word,
        style: TextStyle(
          color: Colors.black87,
          fontSize: 20.0,
        ),
      );
    }

    TextSpan _hardWord(String word) {
      return TextSpan(
        text: word,
        style: TextStyle(
          color: Colors.black87,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      );
    }

    return AlertDialog(
      title: _title(),
      content: RichText(
        text: TextSpan(
          children: <TextSpan>[
            _normalWord("Infelizmente não foi dessa vez!"),
            _normalWord("    A palavra era "),
            _hardWord(word),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Fechar',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              )),
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
