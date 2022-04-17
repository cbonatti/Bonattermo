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
      child: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: entries.length - 1,
        itemBuilder: (BuildContext context, int index) {
          return _buildListItem(entries, index);
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(
          height: 6.0,
          thickness: 1.0,
        ),
      ),
    );
  }

  Widget _buildListItem(List<String> entries, int index) {
    var result = entries[index].split(',');
    var color = Colors.white;
    var msg = '';

    if (result[1] == true.toString()) {
      color = Colors.green;
      msg = 'Acertou a palavra ${result[0]} em ${result[2]} tentativas';
    } else if (result[1] == false.toString()) {
      color = Colors.red;
      msg = 'Errou a palavra ${result[0]} em ${result[2]} tentativas';
    }
    return Container(
      height: 50,
      color: color,
      child: Center(child: Text(msg)),
    );
  }
}
