import 'package:bonattermo/main.dart';
import 'package:flutter/material.dart';

class WonGameDialogBox extends StatelessWidget {
  const WonGameDialogBox(this.word, this.trys) : super();
  final String word;
  final int trys;

  @override
  Widget build(BuildContext context) {
    Widget _title() {
      return Text(
        "Parabéns !!",
        style: TextStyle(
          color: Colors.green,
          fontWeight: FontWeight.bold,
          fontSize: 40.0,
        ),
      );
    }

    TextSpan _normalWord(String word) {
      return TextSpan(
        text: word,
        style: TextStyle(
          color: Colors.green,
          fontSize: 20.0,
        ),
      );
    }

    TextSpan _hardWord(String word) {
      return TextSpan(
        text: word,
        style: Theme.of(context)
            .textTheme
            .bodyText1
            ?.copyWith(fontWeight: FontWeight.bold, fontSize: 20.0),
      );
    }

    return AlertDialog(
      title: _title(),
      content: RichText(
        text: TextSpan(
          children: <TextSpan>[
            _normalWord("Você acertou a palavra "),
            _hardWord(word),
            _normalWord(" em "),
            _hardWord(trys.toString()),
            _normalWord(" tentativas"),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(
            'Fechar',
            style: Theme.of(context).textTheme.bodyText1,
          ),
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
