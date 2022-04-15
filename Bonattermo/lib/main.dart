import 'package:bonattermo/game.dart';
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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Bonattermo'),
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
  Future<String> loadAsset() async {
    return await rootBundle.loadString('assets/words.txt');
  }

  final _random = new Random();
  int next(int min, int max) => min + _random.nextInt(max - min);

  void _newGame() async {
    var allWords = await loadAsset();
    List<String> words = [];
    for (var item in allWords.split('\n')) {
      words.add(item.substring(0, 5));
    }

    var index = next(0, words.length);
    var word = words[index];

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Game(word.toUpperCase(), words, 6)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Bem-vindo ao Bonattermo',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _newGame,
        tooltip: 'Novo Jogo',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
