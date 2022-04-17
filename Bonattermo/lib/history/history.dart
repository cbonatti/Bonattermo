import 'package:flutter/material.dart';
import 'history-file.dart';
import 'snapshot-data.dart';
import 'snapshot-error.dart';
import 'snapshot-loading.dart';

class History extends StatelessWidget {
  const History({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: HistoryFile.loadHistoryFile(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SnapshotData(snapshot.data);
        } else if (snapshot.hasError) {
          return SnapshopError(snapshot.error);
        } else {
          return SnapshotLoading();
        }
      },
    );
  }
}
