import 'package:flutter/material.dart';

import 'howToPlay.dart';

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
  List<String> letterExists = [];
  List<String> letterNonExists = [];
  double screenWidth = 0.0;

  void _showToast(String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        duration: Duration(milliseconds: 600),
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

  void _checkLetters() {
    String word = wordsTryed[actualTry - 1];
    for (var i = 0; i < 5; i++) {
      String letter = word.characters.elementAt(i);
      if (widget.word.contains(letter)) {
        letterExists.add(letter);
      } else {
        letterNonExists.add(letter);
      }
    }
  }

  void _nextWord() {
    if (actualTry <= widget.totalOfTrys - 1) {
      String word = wordsTryed[actualTry - 1];
      for (var i = 0; i < 5; i++) {
        String letter = word.characters.elementAt(i);
        if (widget.word.characters.elementAt(i) == letter) {
          String nextWord = wordsTryed[actualTry];
          nextWord =
              nextWord.substring(0, i) + letter + nextWord.substring(i + 1);
          wordsTryed[actualTry] = nextWord;
        }
      }
    }
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

      _checkLetters();
      _nextWord();

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

  void _changeCursor(int index) {
    setState(() {
      cursorPosition = index;
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

    return GestureDetector(
      onTap: () => _changeCursor(index),
      child: Container(
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
              fontSize: 47.0,
            ),
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
    var color = Colors.blueGrey[600];
    var borderColor = Colors.black;
    if (letterNonExists.contains(letter)) {
      color = Colors.grey[200];
      borderColor = Colors.grey;
    }
    if (letterExists.contains(letter)) {
      color = Colors.blue;
    }

    return GestureDetector(
      onTap: () => _typeLetter(letter),
      child: Container(
        height: 45.0,
        width: screenWidth / 12,
        margin: const EdgeInsets.all(2.0),
        padding: const EdgeInsets.all(1.0),
        decoration:
            BoxDecoration(border: Border.all(color: borderColor), color: color),
        child: Center(
          child: Text(
            letter.toUpperCase(),
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _createBackspaceKey() {
    var color = Colors.blueGrey[600];
    return GestureDetector(
      onTap: () => _backspace(),
      child: Container(
        height: 45.0,
        width: screenWidth / 12,
        margin: const EdgeInsets.all(2.0),
        padding: const EdgeInsets.all(1.0),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black), color: color),
        child: Center(
          child: Icon(
            Icons.backspace_outlined,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _createEnterKey() {
    var color = Colors.blueGrey[600];
    return GestureDetector(
      onTap: () => _enter(),
      child: Container(
        height: 45.0,
        width: (screenWidth / 12) * 2.5,
        margin: const EdgeInsets.fromLTRB(8.0, 2.0, 2.0, 2.0),
        padding: const EdgeInsets.all(1.0),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black), color: color),
        child: Center(
          child: Text(
            'ENTER',
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
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
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('BonaTTermo'),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CustomDialogBox();
                      });
                },
                child: Icon(
                  Icons.info,
                  size: 26.0,
                ),
              )),
        ],
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

class CustomDialogBox extends StatelessWidget {
  const CustomDialogBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 1,
      backgroundColor: Colors.white,
      child: HowToPlay(),
    );
  }
}
