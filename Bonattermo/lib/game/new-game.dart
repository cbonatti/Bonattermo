import 'dart:math';

import 'package:bonattermo/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class NewGame {
  Future<String> _loadAsset() async {
    return await rootBundle.loadString('assets/words.txt');
  }

  final _random = new Random();
  int next(int min, int max) => min + _random.nextInt(max - min);

  void newGame(BuildContext context) async {
    var allWords = await _loadAsset();
    List<String> words = [];
    for (var item in allWords.split('\n')) {
      words.add(item.substring(0, 5));
    }

    var index = next(0, words.length);
    var word = words[index];
    print(word);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Game(word.toUpperCase(), words, 6)),
    );
  }
}
