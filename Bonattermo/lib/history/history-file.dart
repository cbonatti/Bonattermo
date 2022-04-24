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

  static Future<File> appendToFile(String text) async {
    final file = await getFile();
    return file.writeAsString(text, mode: FileMode.append);
  }

  static Future<File> changeLastLine(String text) async {
    final content = await loadHistoryFile();

    var aux = content.substring(0, content.length - 5);
    var index = aux.lastIndexOf('\n');
    var newContent = '';
    if (index != -1) newContent = content.substring(0, index);
    newContent += text;
    final file = await getFile();
    return file.writeAsString(newContent, mode: FileMode.write);
  }
}
