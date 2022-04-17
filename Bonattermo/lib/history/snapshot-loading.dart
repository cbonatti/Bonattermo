import 'package:flutter/material.dart';

class SnapshotLoading extends StatelessWidget {
  const SnapshotLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 60,
            height: 60,
            child: CircularProgressIndicator(),
          ),
          Padding(
            padding: EdgeInsets.only(top: 16),
            child: Text('Carregando resultados...'),
          )
        ],
      ),
    );
  }
}
