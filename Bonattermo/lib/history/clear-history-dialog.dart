import 'package:flutter/material.dart';

class ConfirmClearHistoryDialogBox extends StatelessWidget {
  const ConfirmClearHistoryDialogBox(this.onTap) : super();
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Limpar histórico",
          style: Theme.of(context).textTheme.titleLarge),
      content: Text('Deseja mesmo limpar o histórico?'),
      actions: <Widget>[
        TextButton(
          child: Text('Não', style: Theme.of(context).textTheme.bodyText1),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Sim', style: Theme.of(context).textTheme.bodyText1),
          onPressed: () {
            onTap();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
