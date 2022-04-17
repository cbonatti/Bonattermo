import 'package:flutter/material.dart';
import 'action-button.dart';
import 'history/clear-history-dialog.dart';
import 'game/new-game.dart';
import 'history/history-file.dart';
import 'history/history.dart';
import 'howToPlay.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BonaTTermo'),
        actions: [
          ActionButton.create(context, HowToPlayDialogBox(), Icons.info),
          ActionButton.create(
            context,
            ConfirmClearHistoryDialogBox(
              () async => {
                await HistoryFile.deleteFile(),
                setState(() {}), // force reload list
              },
            ),
            Icons.delete,
          ),
        ],
      ),
      body: History(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => NewGame().newGame(context),
        tooltip: 'Novo Jogo',
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}
