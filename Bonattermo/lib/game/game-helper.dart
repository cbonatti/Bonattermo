import 'dart:io';

import 'package:bonattermo/history/history-file.dart';
import 'package:flutter/material.dart';

import '../lose-game-dialog.dart';
import '../won-game-dialog.dart';

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

  WordStyle getWordStyle(
    String letter,
    int wordIndex,
    int cursorPosition,
    int gameIndex,
    int actualTry,
  ) {
    Color color = Colors.white;
    Color borderColor = Colors.blueAccent;
    double borderWidth = 1.0;

    if (letter != ' ') {
      color = Colors.red;
    }
    if (word.contains(letter)) {
      color = Colors.blue;
      if (word[wordIndex] == letter) {
        color = Colors.green;
      }
    }
    if (cursorPosition == wordIndex && gameIndex == actualTry) {
      borderColor = Colors.black;
      borderWidth = 3.0;
    }
    if (gameIndex == actualTry) {
      color = Colors.white;
    }

    return WordStyle(color, borderColor, borderWidth);
  }
}

class WordStyle {
  late Color color;
  late Color borderColor;
  late double borderWidth;

  WordStyle(this.color, this.borderColor, this.borderWidth);
}
