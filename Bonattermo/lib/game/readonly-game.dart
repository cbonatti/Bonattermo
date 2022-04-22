import 'package:flutter/material.dart';

import 'game-builder.dart';
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
    var builder =
        GameBuilder(helper, widget.wordsTryed, widget.word, context, 0, 0);
    return AlertDialog(
      content: Center(
        child: Column(
          children: [
            ...builder.buildGame(),
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
