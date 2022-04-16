import 'package:bonattermo/game.dart';
import 'package:bonattermo/howToPlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:math';

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
      home: MyHomePage(title: 'BonaTTermo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<String> _loadAsset(String path) async {
    return await rootBundle.loadString('assets/' + path);
  }

  final _random = new Random();
  int next(int min, int max) => min + _random.nextInt(max - min);

  void _newGame() async {
    var allWords = await _loadAsset('words.txt');
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

  Future<String> _loadHistory() async {
    var history = await _loadAsset('game-history.txt');
    //return history;
    return Future<String>.delayed(
      const Duration(seconds: 2),
      () => history,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
        ],
      ),
      body: FutureBuilder<String>(
        future: _loadHistory(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              child: Text(snapshot.data.toString()),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Erro ao carregar histórico'),
                  )
                ],
              ),
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('Carregando resultados...'),
                  )
                ],
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _newGame,
        tooltip: 'Novo Jogo',
        child: Icon(Icons.play_arrow),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
