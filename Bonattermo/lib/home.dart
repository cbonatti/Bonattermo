import 'package:bonattermo/statistics/statistics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'action-button.dart';
import 'history/clear-history-dialog.dart';
import 'game/new-game.dart';
import 'history/history-file.dart';
import 'history/history.dart';
import 'howToPlay.dart';
import 'theme/dark-theme-provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('BonaTTermo'),
        actions: [
          ActionButton.create(context, HowToPlayDialogBox(), Icons.info),
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StatisticsPage()),
                );
              },
              child: Icon(
                Icons.auto_graph,
                size: 26.0,
              ),
            ),
          ),
          Container(
            height: 10,
            width: 30,
            margin: EdgeInsets.only(right: 10.0),
            child: SwitchListTile(
              title: Text("Dark Mode"),
              onChanged: (val) {
                themeChange.darkTheme = val;
              },
              value: themeChange.darkTheme,
            ),
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
