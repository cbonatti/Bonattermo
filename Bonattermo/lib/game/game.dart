import 'package:flutter/material.dart';
import '../action-button.dart';
import '../howToPlay.dart';
import '../lose-game-dialog.dart';
import '../won-game-dialog.dart';
import 'game-helper.dart';

class Game extends StatefulWidget {
  const Game(this.word, this.words, this.totalOfTrys) : super();
  final String word;
  final List<String> words;
  final totalOfTrys;

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  late GameHelper helper;
  bool gameFinished = false;

  int actualTry = 1;
  int cursorPosition = 0;

  List<String> wordsTryed = [];
  List<String> letterExists = [];
  List<String> letterNonExists = [];

  double screenWidth = 0.0;

  void _typeLetter(String letter) {
    if (gameFinished) return;
    setState(() {
      replaceActualWord(cursorPosition, letter);
      if (cursorPosition < (widget.word.length - 1)) {
        _changeCursor(cursorPosition + 1);
        _checkActualWord();
      }
    });
  }

  void replaceActualWord(int index, String newChar) {
    String word = wordsTryed[actualTry - 1];
    word = word.substring(0, index) + newChar + word.substring(index + 1);
    wordsTryed[actualTry - 1] = word;
  }

  void _checkWhetherTypedLettersAreInSercretWord() {
    String word = wordsTryed[actualTry - 1];
    for (var i = 0; i < word.length; i++) {
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
      _checkNextWord();
    }
  }

  void _checkNextWord() {
    String nextWord = wordsTryed[actualTry];
    for (var i = 0; i < nextWord.length; i++) {
      if (nextWord.characters.elementAt(i) != ' ') {
        _changeCursor(i + 1);
      } else {
        return;
      }
    }
  }

  void _checkActualWord() {
    String word = wordsTryed[actualTry - 1];
    for (var i = cursorPosition; i < word.length; i++) {
      if (word.characters.elementAt(i) != ' ') {
        _changeCursor(i + 1);
      } else {
        return;
      }
    }
  }

  void _enter() {
    if (gameFinished) return;

    String word = wordsTryed[actualTry - 1];
    if (!helper.validateWord(word)) return;

    setState(() {
      if (helper.checkWonGame(word, actualTry, wordsTryed)) {
        gameFinished = true;
        return;
      }

      // must be before next checks, because it will be repositioned, like if the first letter exists, move to second
      _changeCursor(0);

      _checkWhetherTypedLettersAreInSercretWord();
      _nextWord();

      actualTry++;

      if (helper.checkLostGame(actualTry, wordsTryed)) {
        gameFinished = true;
        return;
      }
    });
  }

  void _backspace() {
    if (gameFinished) return;

    String word = wordsTryed[actualTry - 1];
    setState(() {
      // checking in the actual word beacause if the cursor is in the last letter it was skipping it and erasing all the rest
      if (word.characters.elementAt(cursorPosition) == ' ' &&
          cursorPosition > 0) _changeCursor(cursorPosition - 1);
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
    return GestureDetector(
      onTap: () => _enter(),
      child: Container(
        height: 45.0,
        width: (screenWidth / 12) * 2.5,
        margin: const EdgeInsets.fromLTRB(8.0, 2.0, 2.0, 2.0),
        padding: const EdgeInsets.all(1.0),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            color: Colors.blueGrey[600]),
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
    helper = GameHelper(context, widget.word, widget.words, widget.totalOfTrys);
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('BonaTTermo'),
        actions: [
          ActionButton.create(context, HowToPlayDialogBox(), Icons.info),
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
