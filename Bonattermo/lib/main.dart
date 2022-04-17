import 'package:bonattermo/howToPlay.dart';
import 'package:flutter/material.dart';

import 'clear-history-dialog.dart';
import 'game/new-game.dart';
import 'history/history.dart';
import 'history/history-file.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BonaTTermo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BonaTTermo'),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return HowToPlayDialogBox();
                      });
                },
                child: Icon(
                  Icons.info,
                  size: 26.0,
                ),
              )),
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ConfirmClearHistoryDialogBox(() async => {
                              await HistoryFile.deleteFile(),
                              setState(() {}),
                            });
                      });
                },
                child: Icon(
                  Icons.delete,
                  size: 26.0,
                ),
              )),
        ],
      ),
      body: History(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => NewGame().newGame(context),
        tooltip: 'Novo Jogo',
        child: Icon(Icons.play_arrow),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
