import 'package:flutter/material.dart';

class SnapshotData extends StatelessWidget {
  final String? data;
  const SnapshotData(this.data) : super();

  @override
  Widget build(BuildContext context) {
    if (data == '') {
      return Container();
    }
    var entries = data.toString().split('\n');
    return Container(
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: entries.length - 1,
        itemBuilder: (BuildContext context, int index) {
          return _buildListItem(entries, index);
        },
      ),
    );
  }

  Widget _buildListItem(List<String> entries, int index) {
    var result = entries[index].split(',');
    String word = result[0];
    bool won = result[1] == true.toString();
    String trys = result[2];
    String wordsTryed = result[3].replaceAll(';', ', ');
    wordsTryed = wordsTryed.substring(0, wordsTryed.length - 2);

    if (won)
      return Card(
        child: ListTile(
          leading: Icon(
            Icons.thumb_up,
            color: Colors.green,
          ),
          title: Text(word),
          subtitle: Text(
            wordsTryed,
            style: TextStyle(fontSize: 10.0),
          ),
          trailing: Text('$trys tentativas'),
        ),
      );

    return Card(
      child: ListTile(
        leading: Icon(
          Icons.thumb_down,
          color: Colors.red,
        ),
        title: Text(word),
        subtitle: Text(
          wordsTryed,
          style: TextStyle(fontSize: 10.0),
        ),
        trailing: Text('$trys tentativas'),
      ),
    );
  }
}
