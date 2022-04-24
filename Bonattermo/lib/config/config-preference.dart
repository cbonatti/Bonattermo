import 'package:shared_preferences/shared_preferences.dart';

class ConfigPreference {
  static const DIFFICULTY = "DIFFICULTY";
  static const GAME_STYLE = "GAMESTYLE";

  setDifficulty(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(DIFFICULTY, value);
  }

  Future<int> getDifficulty() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(DIFFICULTY) ?? 1;
  }

  setGameStyle(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(GAME_STYLE, value);
  }

  Future<int> getGameStyle() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(GAME_STYLE) ?? 1;
  }
}
