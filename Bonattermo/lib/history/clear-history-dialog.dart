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
        FlatButton(
          child: Text('Não'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text('Sim'),
          onPressed: () {
            onTap();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
