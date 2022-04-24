import 'package:flutter/material.dart';

import 'game-helper.dart';

class GameBuilder {
  final GameHelper helper;
  final List<String> wordsTryed;
  final String word;
  final BuildContext context;
  final int cursorPosition;
  final int actualTry;
  final Function(int) onTap;

  GameBuilder(this.helper, this.wordsTryed, this.word, this.context,
      this.cursorPosition, this.actualTry, this.onTap);

  List<Widget> buildGame() {
    List<Widget> widgets = [];
    for (var i = 1; i <= wordsTryed.length; i++) {
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

    var wordStyle = helper.getWordStyle(
        context, word, letter, index, cursorPosition, gameIndex, actualTry);
    return GestureDetector(
      onTap: () {
        Function.apply(onTap, [index]);
      },
      child: Container(
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
      ),
    );
  }
}
