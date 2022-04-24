import 'package:bonattermo/history/history-file.dart';
import 'package:bonattermo/history/snapshot-error.dart';
import 'package:bonattermo/history/snapshot-loading.dart';
import 'package:flutter/material.dart';
import 'new-game.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: HistoryFile.loadHistoryFile(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == '') {
            NewGame().newGame(context);
            return Container();
          }
          var entries = snapshot.data.toString().split('\n');
          var lastGame = entries[entries.length - 2].split(',');
          print(lastGame);
          if (lastGame[1].trim() == '-')
            NewGame().loadGame(context, lastGame[0], lastGame[3].split(';'));
          else
            NewGame().newGame(context);
          return Container();
        } else if (snapshot.hasError) {
          return SnapshopError(snapshot.error);
        } else {
          return SnapshotLoading();
        }
      },
    );
  }
}
