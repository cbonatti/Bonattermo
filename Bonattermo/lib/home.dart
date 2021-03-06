import 'package:bonattermo/config/config.dart';
import 'package:bonattermo/statistics/statistics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'action-button.dart';
import 'game/game-page.dart';
import 'history/history.dart';
import 'howToPlay.dart';
import 'theme/dark-theme-provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void handleClick(int item) {
    switch (item) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => StatisticsPage()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ConfigPage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('BonaTTermo'),
        actions: [
          ActionButton.create(context, HowToPlayDialogBox(), Icons.info),
          PopupMenuButton<int>(
            onSelected: (item) => handleClick(item),
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                  value: 0,
                  child: Row(
                    children: [
                      Icon(
                        Icons.auto_graph,
                        size: 26.0,
                        color:
                            themeChange.darkTheme ? Colors.white : Colors.black,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text('Estatísticas'),
                      ),
                    ],
                  )),
              PopupMenuItem<int>(
                  value: 1,
                  child: Row(
                    children: [
                      Icon(
                        Icons.settings,
                        size: 26.0,
                        color:
                            themeChange.darkTheme ? Colors.white : Colors.black,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text('Configurações'),
                      ),
                    ],
                  )),
            ],
          ),
        ],
      ),
      body: History(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => GamePage()),
          ),
        },
        tooltip: 'Novo Jogo',
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}
