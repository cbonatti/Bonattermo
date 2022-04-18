import 'package:flutter/material.dart';

class ConfirmClearHistoryDialogBox extends StatelessWidget {
  const ConfirmClearHistoryDialogBox(this.onTap) : super();
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Limpar histórico",
          style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 20.0)),
      content: Text('Deseja mesmo limpar o histórico?'),
      actions: <Widget>[
        TextButton(
          child: Text('Não',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              )),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Sim',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              )),
          onPressed: () {
            onTap();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
