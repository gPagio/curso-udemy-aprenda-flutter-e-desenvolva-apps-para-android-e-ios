import 'package:flutter/material.dart';

class Resposta extends StatelessWidget {
  final String _resposta;
  final void Function() _onPressed;

  const Resposta(this._resposta, this._onPressed, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        onPressed: this._onPressed,
        child: Text(this._resposta),
      ),
    );
  }
}
