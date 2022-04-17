import 'package:flutter/material.dart';

class HowToPlayDialogBox extends StatelessWidget {
  const HowToPlayDialogBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: HowToPlay(),
      title: Text(
        'Como jogar:',
        style: TextStyle(
            color: Colors.black87, fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Fechar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}

class HowToPlay extends StatelessWidget {
  const HowToPlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _wordBox(String letter, Color color) {
      return Container(
        height: 60.0,
        width: 50.0,
        margin: const EdgeInsets.all(3.0),
        decoration:
            BoxDecoration(border: Border.all(color: color), color: color),
        child: Center(
          child: Text(
            letter.toUpperCase(),
            style: TextStyle(
              fontSize: 47.0,
            ),
          ),
        ),
      );
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            'Você tem 6 tentativas para descobrir a palavra secreta.',
            style: TextStyle(color: Colors.black87, fontSize: 17.0),
          ),
          Text(
            'A cada nova tentativa, a palavra anterior dará dicas de quão próximo está de descobrir:',
            style: TextStyle(color: Colors.black87, fontSize: 17.0),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _wordBox('F', Colors.green),
                _wordBox('E', Colors.blue),
                _wordBox('I', Colors.blue),
                _wordBox('O', Colors.blue),
                _wordBox('S', Colors.red),
              ],
            ),
          ),
          RichText(
            text: TextSpan(children: <TextSpan>[
              _normalWord("No exemplo acima, a cor "),
              _emphasisWord("vermelha", Colors.red),
              _normalWord(" indica que a palavra secreta "),
              _normalWord("não", bold: true),
              _normalWord(" contém a letra "),
              _emphasisWord("S", Colors.red),
              _normalWord("."),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: RichText(
              text: TextSpan(children: <TextSpan>[
                _normalWord("A cor "),
                _emphasisWord("azul", Colors.blue),
                _normalWord(" indica que as letras "),
                _emphasisWord("E", Colors.blue),
                _normalWord(", "),
                _emphasisWord("I", Colors.blue),
                _normalWord(" e "),
                _emphasisWord("O", Colors.blue),
                _normalWord(
                  ", pertencem a palavra secreta, mas não estão na posição correta.",
                ),
              ]),
            ),
          ),
          RichText(
            text: TextSpan(children: <TextSpan>[
              _normalWord("Já a cor "),
              _emphasisWord("verde", Colors.green),
              _normalWord(" mostra que a letra "),
              _emphasisWord("F", Colors.green),
              _normalWord(" está na posição correta."),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Text(
              'Para validar a palavra clique:',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.red),
            ),
          ),
          _createEnter(),
        ],
      ),
    );
  }

  TextSpan _normalWord(String text, {bool bold = false}) {
    return TextSpan(
        text: text,
        style: TextStyle(
            color: Colors.black87,
            fontSize: 17.0,
            fontWeight: bold ? FontWeight.bold : FontWeight.normal));
  }

  TextSpan _emphasisWord(String text, Color color) {
    return TextSpan(
        text: text,
        style: TextStyle(
            color: color, fontWeight: FontWeight.bold, fontSize: 20.0));
  }

  Widget _createEnter() {
    return Container(
      height: 45.0,
      width: 80,
      margin: const EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 2.0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black), color: Colors.blueGrey[600]),
      child: Center(
        child: Text(
          'ENTER',
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
