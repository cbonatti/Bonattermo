import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme/dark-theme-provider.dart';
import 'config-preference.dart';
import 'config-provider.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({Key? key}) : super(key: key);

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  ConfigProvider config = ConfigProvider();
  ConfigPreference configPreference = ConfigPreference();

  Widget _createChoise(String text, int value) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ChoiceChip(
        label: Text(text),
        selected: config.difficulty == value,
        onSelected: (val) {
          setState(() {
            config.difficulty = value;
            configPreference.setDifficulty(value);
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Container(
                  height: 50,
                  width: 215,
                  child: SwitchListTile(
                    title: Text("Modo Escuro"),
                    onChanged: (val) {
                      themeChange.darkTheme = val;
                    },
                    value: themeChange.darkTheme,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text('Dificuldade: '),
              ),
              _createChoise('Fácil', 0),
              _createChoise('Médio', 1),
              _createChoise('Difícil', 2),
            ],
          ),
        ],
      ),
    );
  }
}
