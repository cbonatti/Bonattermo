import 'package:flutter/material.dart';

class HowToPlay extends StatelessWidget {
  const HowToPlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _wordBox(int index, String word, String secretWord) {
      String letter = word[index].toUpperCase();
      Color color = Colors.white;
      Color borderColor = Colors.blueAccent;

      if (letter != ' ') {
        color = Colors.red;
      }
      if (secretWord.contains(letter)) {
        color = Colors.blue;
        if (secretWord[index] == letter) {
          color = Colors.green;
        }
      }

      return Container(
        height: 60.0,
        width: 50.0,
        margin: const EdgeInsets.all(3.0),
        padding: const EdgeInsets.all(3.0),
        decoration:
            BoxDecoration(border: Border.all(color: borderColor), color: color),
        child: Center(
          child: Text(
            letter.toUpperCase(),
            style: TextStyle(
              fontSize: 50.0,
            ),
          ),
        ),
      );
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(padding: EdgeInsets.only(top: 30.0)),
          Text(
            'Como jogar:',
            style: TextStyle(
                color: Colors.black87,
                fontSize: 25.0,
                fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Você tem 6 tentativas para descobrir a palavra secreta. A cada tentativa, a palavra anterior exibirá dica de quão próximo está de descobrir:',
              style: TextStyle(color: Colors.black87, fontSize: 20.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                _wordBox(0, 'FEIOS', 'FREIO'),
                _wordBox(1, 'FEIOS', 'FREIO'),
                _wordBox(2, 'FEIOS', 'FREIO'),
                _wordBox(3, 'FEIOS', 'FREIO'),
                _wordBox(4, 'FEIOS', 'FREIO'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0, left: 20.0, top: 20.0),
            child: RichText(
              text: TextSpan(children: <TextSpan>[
                TextSpan(
                    text: "No exemplo acima, a cor ",
                    style: TextStyle(color: Colors.black87, fontSize: 20.0)),
                TextSpan(
                    text: "vermelha",
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0)),
                TextSpan(
                    text: " indica que a palavra secreta não contém a letra ",
                    style: TextStyle(color: Colors.black87, fontSize: 20.0)),
                TextSpan(
                    text: "S",
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0)),
                TextSpan(
                    text: ".",
                    style: TextStyle(color: Colors.black87, fontSize: 20.0)),
              ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0, left: 20.0, top: 10.0),
            child: RichText(
              text: TextSpan(children: <TextSpan>[
                TextSpan(
                    text: "A cor ",
                    style: TextStyle(color: Colors.black87, fontSize: 20.0)),
                TextSpan(
                    text: "azul",
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0)),
                TextSpan(
                    text: " indica que as letras ",
                    style: TextStyle(color: Colors.black87, fontSize: 20.0)),
                TextSpan(
                    text: "E",
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0)),
                TextSpan(
                    text: ", ",
                    style: TextStyle(color: Colors.black87, fontSize: 20.0)),
                TextSpan(
                    text: "I",
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0)),
                TextSpan(
                    text: " e ",
                    style: TextStyle(color: Colors.black87, fontSize: 20.0)),
                TextSpan(
                    text: "O",
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0)),
                TextSpan(
                    text:
                        ", pertencem a palavra secreta, mas não estão na posição correta.",
                    style: TextStyle(color: Colors.black87, fontSize: 20.0)),
              ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0, left: 20.0, top: 10.0),
            child: RichText(
              text: TextSpan(children: <TextSpan>[
                TextSpan(
                    text: "Já a cor ",
                    style: TextStyle(color: Colors.black87, fontSize: 20.0)),
                TextSpan(
                    text: "verde",
                    style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0)),
                TextSpan(
                    text: " mostra que a letra ",
                    style: TextStyle(color: Colors.black87, fontSize: 20.0)),
                TextSpan(
                    text: "F",
                    style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0)),
                TextSpan(
                    text: " está na posição correta.",
                    style: TextStyle(color: Colors.black87, fontSize: 20.0)),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
