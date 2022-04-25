import 'package:flutter/material.dart';

import 'config-preference.dart';

class ConfigProvider with ChangeNotifier {
  ConfigPreference configPreference = ConfigPreference();
  int _difficulty = 0;
  int _gameStyle = 1;

  int get difficulty => _difficulty;

  set difficulty(int value) {
    _difficulty = value;
    configPreference.setDifficulty(value);
    notifyListeners();
  }

  int get gameStyle => _gameStyle;

  set gameStyle(int value) {
    _gameStyle = value;
    configPreference.setGameStyle(value);
    notifyListeners();
  }
}
