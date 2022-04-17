import 'dart:io';

import 'package:bonattermo/game.dart';
import 'package:bonattermo/howToPlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:math';

import 'package:path_provider/path_provider.dart';

import 'clear-history-dialog.dart';

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
  Future<String> _loadAsset() async {
    return await rootBundle.loadString('assets/words.txt');
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/game-history.txt');
  }

  Future<String> _loadHistoryFile() async {
    try {
      final file = await _localFile;
      final contents = await file.readAsString();
      return contents;
    } catch (e) {
      return '';
    }
  }

  final _random = new Random();
  int next(int min, int max) => min + _random.nextInt(max - min);

  void _newGame() async {
    var allWords = await _loadAsset();
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

  void _clearHistory() async {
    final file = await _localFile;
    file.delete();
    setState(() {});
  }

  Future<String> _loadHistory() async {
    var history = await _loadHistoryFile();
    return history;
  }

  Widget _buildListItem(List<String> entries, int index) {
    var result = entries[index].split(',');
    var color = Colors.white;
    var msg = '';

    if (result[1] == true.toString()) {
      color = Colors.green;
      msg = 'Acertou a palavra ${result[0]} em ${result[2]} tentativas';
    } else if (result[1] == false.toString()) {
      color = Colors.red;
      msg = 'Errou a palavra ${result[0]} em ${result[2]} tentativas';
    }
    return Container(
      height: 50,
      color: color,
      child: Center(child: Text(msg)),
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
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ConfirmClearHistoryDialogBox(
                            () => _clearHistory());
                      });
                },
                child: Icon(
                  Icons.delete,
                  size: 26.0,
                ),
              )),
        ],
      ),
      body: FutureBuilder<String>(
        future: _loadHistory(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == '') {
              return Container();
            }
            var entries = snapshot.data.toString().split('\n');
            return Container(
              child: ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: entries.length - 1,
                itemBuilder: (BuildContext context, int index) {
                  return _buildListItem(entries, index);
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(
                      height: 6.0,
                  thickness: 1.0,
                ),
              ),
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
                    child: Text(
                        'Erro ao carregar histórico. Error: ${snapshot.error}'),
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
