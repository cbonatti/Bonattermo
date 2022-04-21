import 'package:bonattermo/theme/dark-theme-provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatisticsSnapshotData extends StatelessWidget {
  final String? data;
  const StatisticsSnapshotData(this.data) : super();

  @override
  Widget build(BuildContext context) {
    if (data == '') {
      return Container();
    }

    var entries = data.toString().split('\n');
    List<Results> results = [];
    for (var item in entries) {
      var aux = item.split(',');
      if (aux.length > 1) {
        String wordsTryed = aux[3].replaceAll(';', ', ');
        wordsTryed = wordsTryed.substring(0, wordsTryed.length - 2);

        var result = Results(aux[0], aux[1], aux[2], wordsTryed);
        results.add(result);
      }
    }

    var wins = results
        .where(
          (element) => element.won == true.toString(),
        )
        .length;
    var winRate = (wins / entries.length) * 100;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _createCard(context, 'Jogos', entries.length.toString()),
            _createCard(context, 'Vitorias', wins.toString()),
            _createCard(context, 'Win Rate', '${winRate.toStringAsFixed(0)}%'),
          ],
        )
      ],
    );
  }

  Widget _createCard(BuildContext context, String title, String subtitle) {
    var screenWidth = MediaQuery.of(context).size.width;
    final themeChange = Provider.of<DarkThemeProvider>(context);
    var borderColor = themeChange.darkTheme
        ? Theme.of(context).buttonTheme.colorScheme?.secondary ?? Colors.grey
        : Theme.of(context).primaryColor;

    return Container(
      height: 150,
      width: screenWidth / 3.5,
      decoration: BoxDecoration(
        border: Border.all(width: 6.0, color: borderColor),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(title),
            Text(
              subtitle,
              style: TextStyle(fontSize: 40.0),
            ),
          ],
        ),
      ),
    );
  }
}

class Results {
  final String word;
  final String won;
  final String trys;
  final String words;

  Results(this.word, this.won, this.trys, this.words);
}
