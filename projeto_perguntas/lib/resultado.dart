import 'package:flutter/material.dart';

class Resultado extends StatelessWidget {
  final int _pontuacaoTotal;
  final void Function() _reiniciarQuestionario;

  const Resultado(
    this._pontuacaoTotal,
    this._reiniciarQuestionario, {
    super.key,
  });

  String get fraseResultado {
    if (_pontuacaoTotal < 8) return "Parabéns!";
    if (_pontuacaoTotal < 12) return "Você é bom!";
    if (_pontuacaoTotal < 16) return "Impressionante!";
    return "Nível Jedi!";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: Text(fraseResultado, style: TextStyle(fontSize: 28))),
        TextButton(
          onPressed: _reiniciarQuestionario,
          child: Text("Reiniciar", style: TextStyle(color: Colors.blue, fontSize: 18)),
        ),
      ],
    );
  }
}
