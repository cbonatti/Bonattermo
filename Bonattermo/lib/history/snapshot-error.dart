import 'package:flutter/material.dart';

class SnapshopError extends StatelessWidget {
  final Object? error;

  const SnapshopError(this.error) : super();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 60,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text('Erro ao carregar histórico. Error: ${error}'),
          )
        ],
      ),
    );
  }
}
