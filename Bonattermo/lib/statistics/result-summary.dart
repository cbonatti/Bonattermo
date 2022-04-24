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
