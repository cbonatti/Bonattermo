import 'package:flutter/material.dart';
import '../action-button.dart';
import '../howToPlay.dart';
import '../main.dart';
import 'game-builder.dart';
import 'game-helper.dart';

class Game extends StatefulWidget {
  const Game(this.word, this.words, this.totalOfTrys, {this.totalOfLetters = 5})
      : super();
  final String word;
  final List<String> words;
  final totalOfTrys;
  final totalOfLetters;

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
        if (i + 1 < word.length) _changeCursor(i + 1);
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

  Widget _createKey(String letter) {
    KeyStyle keyStyle = helper.getKeyStyle(
      letterExists.contains(letter),
      letterNonExists.contains(letter),
    );

    var display = Text(
      letter.toUpperCase(),
      style: TextStyle(
        fontSize: keyStyle.fontSize,
        color: keyStyle.textColor,
      ),
    );
    return helper.createKey(
      display,
      keyStyle,
      () => _typeLetter(letter),
      screenWidth / 12,
      const EdgeInsets.all(2.0),
    );
  }

  Widget _createBackspaceKey() {
    KeyStyle keyStyle = KeyStyle();
    return helper.createKey(
      Icon(
        Icons.backspace_outlined,
        color: keyStyle.textColor,
      ),
      keyStyle,
      () => _backspace(),
      screenWidth / 12,
      const EdgeInsets.all(2.0),
    );
  }

  Widget _createEnterKey() {
    KeyStyle keyStyle = KeyStyle();
    return helper.createKey(
      Text(
        'ENTER',
        style: TextStyle(
          fontSize: keyStyle.fontSize,
          color: keyStyle.textColor,
        ),
      ),
      keyStyle,
      () => _enter(),
      (screenWidth / 12) * 2.5,
      const EdgeInsets.fromLTRB(8.0, 2.0, 2.0, 2.0),
    );
  }

  Widget _createKeyboardKeyRow(List<String> keys) {
    List<Widget> widgets = [];
    for (var key in keys) {
      if (key == 'ENTER')
        widgets.add(_createEnterKey());
      else if (key == 'BS')
        widgets.add(_createBackspaceKey());
      else
        widgets.add(_createKey(key));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widgets,
    );
  }

  Widget _buildKeyboard() {
    return Column(
      children: [
        _createKeyboardKeyRow(
            ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P']),
        _createKeyboardKeyRow(
            ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L', 'BS']),
        _createKeyboardKeyRow(['Z', 'X', 'C', 'V', 'B', 'N', 'M', 'ENTER']),
      ],
    );
  }

  void _onBackPressed() {
    if (actualTry > 1) {
      helper.writeInHistory(false, actualTry - 1, wordsTryed);
    }
    Navigator.of(context).pop();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyApp()),
    );
  }

  void initState() {
    super.initState();
    for (var i = 0; i < widget.totalOfTrys; i++) {
      wordsTryed.add(' '.padRight(widget.totalOfLetters));
    }
    helper = GameHelper(context, widget.word, widget.words, widget.totalOfTrys);
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    var builder = GameBuilder(helper, wordsTryed, widget.word, context,
        cursorPosition, actualTry, _changeCursor);
    return Scaffold(
      appBar: AppBar(
        title: Text('BonaTTermo'),
        leading: BackButton(onPressed: _onBackPressed),
        actions: [
          ActionButton.create(context, HowToPlayDialogBox(), Icons.info),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(padding: EdgeInsets.only(top: 20.0)),
          ...builder.buildGame(),
          Expanded(child: Container()),
          _buildKeyboard(),
          Padding(padding: EdgeInsets.only(bottom: 30.0)),
        ],
      ),
    );
  }
}
