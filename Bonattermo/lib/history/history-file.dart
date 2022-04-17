import 'dart:io';

import 'package:path_provider/path_provider.dart';

class HistoryFile {
  static Future<File> getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    final file = File('$path/game-history.txt');
    return file;
  }

  static Future<String> loadHistoryFile() async {
    try {
      final file = await getFile();
      final contents = await file.readAsString();
      return contents;
    } catch (e) {
      return '';
    }
  }

  static Future deleteFile() async {
    final file = await getFile();
    file.delete();
  }
}
