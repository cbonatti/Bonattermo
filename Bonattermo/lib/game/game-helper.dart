import 'dart:io';

import 'package:bonattermo/history/history-file.dart';
import 'package:bonattermo/theme/dark-theme-provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'lose-game-dialog.dart';
import 'won-game-dialog.dart';

class GameHelper {
  late String word;
  late List<String> words;
  late int totalOfTrys;
  late BuildContext context;

  GameHelper(this.context, this.word, this.words, this.totalOfTrys);

  void showToast(String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        duration: Duration(milliseconds: 600),
        content: Text(message),
      ),
    );
  }

  bool validateWord(String typpedWord) {
    if (typpedWord.contains(' ')) {
      showToast('só palavras com 5 letras');
      return false;
    }
    if (!words.contains(typpedWord.toLowerCase())) {
      showToast('essa palavra não existe');
      return false;
    }
    return true;
  }

  bool checkWonGame(String typpedWord, actualTry, wordsTryed) {
    if (typpedWord == word) {
      writeInHistory(true, actualTry, wordsTryed);
      showDialog(
          context: context, builder: (_) => WonGameDialogBox(word, actualTry));
      return true;
    }
    return false;
  }

  bool checkLostGame(actualTry, wordsTryed) {
    if (actualTry > totalOfTrys) {
      writeInHistory(false, totalOfTrys, wordsTryed);
      showDialog(
        context: context,
        builder: (_) => LoseGameDialogBox(word),
      );
      return true;
    }
    return false;
  }

  Future<File> writeInHistory(
      bool won, int actualTry, List<String> wordsTryed) async {
    String words = '';
    for (var item in wordsTryed) {
      if (!item.contains(' ')) words += '$item;';
    }
    String text = '$word,${won.toString()},${actualTry.toString()},$words\n';
    return HistoryFile.appendToFile(text);
  }

  int _getMatchesCount(String word, String letter) {
    RegExp exp = new RegExp(letter);
    Iterable<RegExpMatch> matches = exp.allMatches(word);
    return matches.length;
  }

  bool _hasAnotherLetterButInCorrectPosition(
    String word,
    String wordTryed,
    String letter,
    int indexToSkip,
  ) {
    for (var i = 0; i < word.length; i++) {
      if (i != indexToSkip) {
        if (word.characters.elementAt(i) == letter &&
            wordTryed.characters.elementAt(i) == letter) return true;
      }
    }
    return false;
  }

  WordStyle getWordStyle(
    BuildContext context,
    String lastTryedWord,
    String letter,
    int wordIndex,
    int cursorPosition,
    int gameIndex,
    int actualTry,
  ) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    Color color = themeChange.darkTheme ? Color(0xff3A3A3B) : Color(0xFFE0E0E0);
    Color borderColor = Colors.grey;
    double borderWidth = 1.0;

    if (letter != ' ') {
      color = Colors.red;
    }
    if (word.contains(letter)) {
      if (word[wordIndex] == letter) {
        color = Colors.green;
      } else {
        var inSecretWord = _getMatchesCount(word, letter);
        var inTypedWord = _getMatchesCount(lastTryedWord, letter);

        if (inSecretWord == inTypedWord) color = Colors.blue;
        if (inTypedWord > inSecretWord) {
          var inStartOfWord = _getMatchesCount(
              lastTryedWord.substring(0, wordIndex + 1), letter);
          if (inSecretWord >= inStartOfWord) {
            if (!_hasAnotherLetterButInCorrectPosition(
                word, lastTryedWord, letter, wordIndex)) color = Colors.blue;
          }
        }
      }
    }
    if (cursorPosition == wordIndex && gameIndex == actualTry) {
      borderColor = themeChange.darkTheme
          ? Theme.of(context).buttonTheme.colorScheme?.secondary ?? Colors.grey
          : Colors.black;
      borderWidth = 3.0;
    }
    if (gameIndex == actualTry) {
      color = themeChange.darkTheme ? Colors.black87 : Colors.white;
    }

    return WordStyle(color, borderColor, borderWidth);
  }

  KeyStyle getKeyStyle(bool exists, bool nonExists) {
    var color = Colors.blueGrey[600];
    var borderColor = Colors.black;
    if (nonExists) {
      color = Colors.grey[200];
      borderColor = Colors.grey;
    }
    if (exists) {
      color = Colors.blue;
    }
    return KeyStyle(color: color, borderColor: borderColor);
  }

  Widget createKey(
    Widget display,
    KeyStyle keyStyle,
    VoidCallback onTap,
    double width,
    EdgeInsets margin,
  ) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        height: keyStyle.height,
        width: width,
        margin: margin,
        decoration: BoxDecoration(
            border: Border.all(color: (keyStyle.borderColor)!),
            color: keyStyle.color),
        child: Center(
          child: display,
        ),
      ),
    );
  }
}

class WordStyle {
  late Color color;
  late Color borderColor;
  late double borderWidth;

  WordStyle(this.color, this.borderColor, this.borderWidth);
}

class KeyStyle {
  late Color? color;
  late Color? borderColor;
  final double height = 45.0;
  final double fontSize = 20.0;
  final Color textColor = Colors.white;

  KeyStyle({
    this.color = const Color(0xFF546E7A),
    this.borderColor = Colors.black,
  });
}
