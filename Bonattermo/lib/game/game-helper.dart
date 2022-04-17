import 'dart:io';

import 'package:bonattermo/history/history-file.dart';
import 'package:flutter/material.dart';

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

  Future<File> writeInHistory(
      bool won, int actualTry, List<String> wordsTryed) async {
    String words = '';
    for (var item in wordsTryed) {
      if (!item.contains(' ')) words += '$item;';
    }
    String text = '$word,${won.toString()},${actualTry.toString()},$words\n';
    return HistoryFile.appendToFile(text);
  }
}
