import 'dart:ffi';

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

        var result = Results(
            aux[0], aux[1] == true.toString(), int.parse(aux[2]), wordsTryed);
        results.add(result);
      }
    }

    var wins = results
        .where(
          (element) => element.won,
        )
        .length;
    var winRate = (wins / results.length) * 100;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _createCard(context, 'Jogos', results.length.toString()),
            _createCard(context, 'Vitorias', wins.toString()),
            _createCard(context, 'Win Rate', '${winRate.toStringAsFixed(0)}%'),
          ],
        ),
        Padding(padding: EdgeInsets.only(top: 20.0)),
        ..._createListPerTry(context, results),
      ],
    );
  }

  Widget _showIndex(String index) {
    if (index != '')
      return Text(
        index,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold),
      );
    return Icon(Icons.dangerous);
  }

  double _getHigherRate(List<ResultSummary> summary) {
    Iterable<double> rates = summary.map((e) => e.getRate());
    var listRates = List<double>.from(rates);
    listRates.sort((a, b) => a.compareTo(b));
    return listRates.last;
  }

  Widget _createProgressBar(Color color, double width, double rate) {
    var text = Text(
      '${rate.toStringAsFixed(0)}%',
      textAlign: TextAlign.right,
      style: TextStyle(fontWeight: FontWeight.bold),
    );

    if (width <= 35) {
      return Row(
        children: [
          Container(
            height: 30.0,
            width: width,
            color: color,
          ),
          text,
        ],
      );
    }

    return Container(
      height: 30.0,
      width: width,
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: text,
      ),
    );
  }

  List<Widget> _createListPerTry(BuildContext context, List<Results> results) {
    var screenWidth = MediaQuery.of(context).size.width;
    final themeChange = Provider.of<DarkThemeProvider>(context);

    var color = themeChange.darkTheme
        ? Theme.of(context).buttonTheme.colorScheme?.secondary ?? Colors.grey
        : Theme.of(context).primaryColor;

    var summary = _getSummary(results);

    List<Widget> widgets = [];

    var maxBarWidth = screenWidth - 100.0;
    var higherRate = _getHigherRate(summary);

    for (var item in summary) {
      var rate = item.getRate();
      var barWidth = (rate * maxBarWidth) / higherRate;

      widgets.add(Row(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 13.0, 10.0, 13.0),
            child: Container(width: 25.0, child: _showIndex(item.index)),
          ),
          _createProgressBar(color, barWidth, rate),
        ],
      ));
    }
    return widgets;
  }

  List<ResultSummary> _getSummary(List<Results> results) {
    results.sort((a, b) => a.trys.compareTo(b.trys));
    var wonGames = results.where((element) => element.won);

    List<ResultSummary> summary = [];
    var higherNumbersOfTry = wonGames.last.trys;
    for (var numbersOfTry = 1;
        numbersOfTry <= higherNumbersOfTry;
        numbersOfTry++) {
      var gamesWonWithThisNumbersOfTry =
          wonGames.where((element) => element.trys == numbersOfTry).length;
      summary.add(ResultSummary(numbersOfTry.toString(),
          gamesWonWithThisNumbersOfTry, wonGames.length));
    }
    summary.add(
        ResultSummary("", results.length - wonGames.length, results.length));
    return summary;
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
              style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class Results {
  final String word;
  final bool won;
  final int trys;
  final String words;

  Results(this.word, this.won, this.trys, this.words);
}

class ResultSummary {
  final String index;
  final int numberOfGamesWonWithThatTry;
  final int numberOfGames;

  double getRate() {
    return (numberOfGamesWonWithThatTry / numberOfGames) * 100;
  }

  String getRateString() {
    return ((numberOfGamesWonWithThatTry / numberOfGames) * 100)
        .toStringAsFixed(1);
  }

  ResultSummary(
      this.index, this.numberOfGamesWonWithThatTry, this.numberOfGames);
}
