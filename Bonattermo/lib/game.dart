import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  const Game(this.word) : super();
  final String word;
  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  bool gameFinished = false;
  final totalOfTrys = 6;
  int actualTry = 1;
  int cursorPosition = 0;
  List<String> wordsTryed = [
    '     ',
    '     ',
    '     ',
    '     ',
    '     ',
    '     '
  ];

  void _typeLetter(String letter) {
    if (gameFinished) return;
    setState(() {
      replaceActualWord(cursorPosition, letter);
      if (cursorPosition < (widget.word.length - 1)) cursorPosition++;
    });
  }

  void replaceActualWord(int index, String newChar) {
    String word = wordsTryed[actualTry - 1];
    word = word.substring(0, index) + newChar + word.substring(index + 1);
    wordsTryed[actualTry - 1] = word;
  }

  void _enter() {
    setState(() {
      actualTry++;
      cursorPosition = 0;
    });
  }

  void _backspace() {
    setState(() {
      replaceActualWord(cursorPosition, ' ');
      if (cursorPosition > 0) cursorPosition--;
    });
  }

  Widget _wordBox(int index, String word, int gameIndex) {
    String letter = word[index].toUpperCase();
    Color color = Colors.white;
    Color borderColor = Colors.blueAccent;

    if (letter != ' ') {
      color = Colors.red;
    }
    if (widget.word.contains(letter)) {
      color = Colors.blue;
      if (widget.word[index] == letter) {
        color = Colors.green;
      }
    }
    if (cursorPosition == index && gameIndex == actualTry) {
      borderColor = Colors.black;
    }
    if (gameIndex == actualTry) {
      color = Colors.white;
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

  Widget _createGameBoard(int index) {
    String word = wordsTryed[index - 1];
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(padding: EdgeInsets.only(top: 30.0)),
        _wordBox(0, word, index),
        _wordBox(1, word, index),
        _wordBox(2, word, index),
        _wordBox(3, word, index),
        _wordBox(4, word, index),
      ],
    );
  }

  Widget _createKey(String letter) {
    var color = Colors.blueGrey;
    return GestureDetector(
      onTap: () => letter == '<--' ? _backspace() : _typeLetter(letter),
      child: Container(
        height: 34.0,
        width: 34.0,
        margin: const EdgeInsets.all(2.0),
        padding: const EdgeInsets.all(1.0),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent), color: color),
        child: Center(
          child: Text(
            letter.toUpperCase(),
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
        ),
      ),
    );
  }

  Widget _createEnterKey() {
    var color = Colors.blueGrey;
    return GestureDetector(
      onTap: () => _enter(),
      child: Container(
        height: 30.0,
        width: 80.0,
        margin: const EdgeInsets.all(3.0),
        padding: const EdgeInsets.all(1.0),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent), color: color),
        child: Center(
          child: Text(
            'ENTER',
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildKeyboard() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _createKey('Q'),
            _createKey('W'),
            _createKey('E'),
            _createKey('R'),
            _createKey('T'),
            _createKey('Y'),
            _createKey('U'),
            _createKey('I'),
            _createKey('O'),
            _createKey('P'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _createKey('A'),
            _createKey('S'),
            _createKey('D'),
            _createKey('F'),
            _createKey('G'),
            _createKey('H'),
            _createKey('J'),
            _createKey('K'),
            _createKey('L'),
            _createKey('<--'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _createKey('Z'),
            _createKey('X'),
            _createKey('C'),
            _createKey('V'),
            _createKey('B'),
            _createKey('N'),
            _createKey('M'),
            _createEnterKey(),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bonattermo'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(padding: EdgeInsets.only(top: 20.0)),
          _createGameBoard(1),
          _createGameBoard(2),
          _createGameBoard(3),
          _createGameBoard(4),
          _createGameBoard(5),
          _createGameBoard(6),
          Expanded(child: Container()),
          _buildKeyboard(),
          Padding(padding: EdgeInsets.only(bottom: 10.0)),
        ],
      ),
    );
  }
}
