import 'package:flutter/material.dart';

import 'game-helper.dart';

class ReadOnlyGame extends StatefulWidget {
  const ReadOnlyGame(this.word, this.wordsTryed, this.won) : super();
  final String word;
  final List<String> wordsTryed;
  final bool won;

  @override
  State<ReadOnlyGame> createState() => _ReadOnlyGameState();
}

class _ReadOnlyGameState extends State<ReadOnlyGame> {
  late GameHelper helper =
      GameHelper(context, widget.word, [], widget.wordsTryed.length);

  List<Widget> _buildGame() {
    List<Widget> widgets = [];
    for (var i = 1; i <= widget.wordsTryed.length - 1; i++) {
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
    for (var i = 0; i < widget.word.length; i++) {
      widgets.add(_wordBox(i, index));
    }
    return widgets;
  }

  Widget _wordBox(int index, int gameIndex) {
    String word = widget.wordsTryed[gameIndex - 1];
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

  Widget _wordOnLost(bool won) {
    if (won) return Container();
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: RichText(
        text: TextSpan(children: <TextSpan>[
          TextSpan(
              text: 'A palavra era ',
              style: Theme.of(context).textTheme.bodyMedium),
          TextSpan(
            text: widget.word,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          )
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Center(
        child: Column(
          children: [
            ..._buildGame(),
            _wordOnLost(widget.won),
          ],
        ),
      ),
      title: Text('Como foi o jogo:',
          style: Theme.of(context).textTheme.titleLarge),
      actions: <Widget>[
        TextButton(
          child: Text('Fechar', style: Theme.of(context).textTheme.bodyText1),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
