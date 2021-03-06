import 'dart:math';
import 'package:bonattermo/config/config-provider.dart';
import 'package:bonattermo/game/game.dart';
import 'package:bonattermo/history/history-file.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class NewGame {
  Future<String> _loadAsset() async {
    return await rootBundle.loadString('assets/words.txt');
  }

  final _random = new Random();
  ConfigProvider config = ConfigProvider();
  int next(int min, int max) => min + _random.nextInt(max - min);

  void newGame(BuildContext context) async {
    var allWords = await _loadAsset();
    List<String> words = [];
    for (var item in allWords.split('\n')) {
      words.add(item.substring(0, 5));
    }

    var index = next(0, words.length);
    var word = words[index];
    String text = '$word,-,0,\n';
    HistoryFile.appendToFile(text);
    print(word);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              Game(word.toUpperCase(), words, _getNumberOfTry(), [])),
    );
  }

  void loadGame(
      BuildContext context, String word, List<String> tryedWords) async {
    var allWords = await _loadAsset();
    List<String> words = [];
    for (var item in allWords.split('\n')) {
      words.add(item.substring(0, 5));
    }
    tryedWords.removeLast();
    print(word);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              Game(word.toUpperCase(), words, _getNumberOfTry(), tryedWords)),
    );
  }

  int _getNumberOfTry() {
    var difficulty = config.difficulty;
    switch (difficulty) {
      case 0:
        return 8;
      case 2:
        return 5;

      default:
        return 6;
    }
  }
}
