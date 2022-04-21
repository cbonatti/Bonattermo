import 'package:bonattermo/history/snapshot-error.dart';
import 'package:bonattermo/history/snapshot-loading.dart';
import 'package:flutter/material.dart';

import '../action-button.dart';
import '../history/clear-history-dialog.dart';
import '../history/history-file.dart';
import '../main.dart';
import 'snapshot-data.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estatísticas'),
        actions: [
          ActionButton.create(
            context,
            ConfirmClearHistoryDialogBox(
              () async => {
                await HistoryFile.deleteFile(),
                Navigator.of(context).pop(),
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()),
                ),
              },
            ),
            Icons.delete,
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(padding: EdgeInsets.only(top: 20.0)),
          Expanded(child: Statistics()),
          Padding(padding: EdgeInsets.only(bottom: 30.0)),
        ],
      ),
    );
  }
}

class Statistics extends StatelessWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: HistoryFile.loadHistoryFile(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return StatisticsSnapshotData(snapshot.data);
        } else if (snapshot.hasError) {
          return SnapshopError(snapshot.error);
        } else {
          return SnapshotLoading();
        }
      },
    );
  }
}
