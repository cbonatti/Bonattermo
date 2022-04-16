import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  const Game(this.word, this.words, this.totalOfTrys) : super();
  final String word;
  final List<String> words;
  final totalOfTrys;
  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  bool gameFinished = false;

  int actualTry = 1;
  int cursorPosition = 0;
  List<String> wordsTryed = [];

  void _showToast(String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
        // action: SnackBarAction(
        //     label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

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
    if (gameFinished) return;
    String word = wordsTryed[actualTry - 1];
    if (word.contains(' ')) {
      _showToast('só palavras com 5 letras');
      return;
    }
    if (!widget.words.contains(word.toLowerCase())) {
      _showToast('essa palavra não existe');
      return;
    }

    setState(() {
      if (word == widget.word) {
        gameFinished = true;
        _showToast('parabéns');
      }

      actualTry++;
      cursorPosition = 0;

      if (actualTry > widget.totalOfTrys) {
        gameFinished = true;
        _showToast('infelizmente não foi dessa vez: ' + widget.word);
      }
    });
  }

  void _backspace() {
    String word = wordsTryed[actualTry - 1];
    setState(() {
      if (word.characters.elementAt(cursorPosition) == ' ' &&
          cursorPosition > 0) cursorPosition--;
      replaceActualWord(cursorPosition, ' ');
    });
  }

  Widget _wordBox(int index, String word, int gameIndex) {
    String letter = word[index].toUpperCase();
    Color color = Colors.white;
    Color borderColor = Colors.blueAccent;
    double borderWidth = 1.0;

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
      borderWidth = 3.0;
    }
    if (gameIndex == actualTry) {
      color = Colors.white;
    }

    return Container(
      height: 60.0,
      width: 50.0,
      margin: const EdgeInsets.all(3.0),
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: borderWidth),
          color: color),
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
      onTap: () => _typeLetter(letter),
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

  Widget _createBackspaceKey() {
    var color = Colors.blueGrey;
    return GestureDetector(
      onTap: () => _backspace(),
      child: Container(
        height: 34.0,
        width: 34.0,
        margin: const EdgeInsets.all(2.0),
        padding: const EdgeInsets.all(1.0),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent), color: color),
        child: Center(
          child: Text(
            '<--',
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
        height: 34.0,
        width: 80.0,
        margin: const EdgeInsets.fromLTRB(8.0, 2.0, 2.0, 2.0),
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
            _createBackspaceKey(),
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

  List<Widget> _buildGame() {
    List<Widget> widgets = [];
    for (var i = 1; i <= widget.totalOfTrys; i++) {
      widgets.add(_createGameBoard(i));
    }
    return widgets;
  }

  void initState() {
    super.initState();
    for (var i = 0; i < widget.totalOfTrys; i++) {
      wordsTryed.add('     ');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BonaTTermo'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(padding: EdgeInsets.only(top: 20.0)),
          ..._buildGame(),
          Expanded(child: Container()),
          _buildKeyboard(),
          Padding(padding: EdgeInsets.only(bottom: 30.0)),
        ],
      ),
    );
  }
}
