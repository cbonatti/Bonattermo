import 'package:flutter/material.dart';

import 'game-helper.dart';

class GameBuilder {
  final GameHelper helper;
  final List<String> wordsTryed;
  final String word;
  final BuildContext context;

  GameBuilder(this.helper, this.wordsTryed, this.word, this.context);

  List<Widget> buildGame() {
    List<Widget> widgets = [];
    for (var i = 1; i <= wordsTryed.length - 1; i++) {
      widgets.add(_createGameBoard(i));
    }
    return widgets;
  }

  Widget _createGameBoard(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _createWordBoxes(index),
    );
  }

  List<Widget> _createWordBoxes(int index) {
    List<Widget> widgets = [];
    for (var i = 0; i < word.length; i++) {
      widgets.add(_wordBox(i, index));
    }
    return widgets;
  }

  Widget _wordBox(int index, int gameIndex) {
    String word = wordsTryed[gameIndex - 1];
    String letter = word[index].toUpperCase();

    var wordStyle =
        helper.getWordStyle(context, word, letter, index, 0, gameIndex, 0);
    return Container(
      height: 60.0,
      width: 50.0,
      margin: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: wordStyle.borderColor,
          width: wordStyle.borderWidth,
        ),
        color: wordStyle.color,
      ),
      child: Center(
        child: Text(
          letter.toUpperCase(),
          style: TextStyle(
            fontSize: 47.0,
          ),
        ),
      ),
    );
  }
}
