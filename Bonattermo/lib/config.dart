import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'theme/dark-theme-provider.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({Key? key}) : super(key: key);

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações'),
      ),
      body: Column(
        children: [
          Container(
            height: 100,
            width: 215,
            child: SwitchListTile(
              title: Text("Modo Escuro"),
              onChanged: (val) {
                themeChange.darkTheme = val;
              },
              value: themeChange.darkTheme,
            ),
          ),
        ],
      ),
    );
  }
}
