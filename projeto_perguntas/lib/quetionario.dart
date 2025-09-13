import 'package:flutter/material.dart';

import './questao.dart';
import './resposta.dart';

class Questionario extends StatelessWidget {
  final List<Map<String, Object>> _perguntas;
  final int _perguntaSelecionada;
  final void Function(int) _responder;

  const Questionario(
    this._perguntas,
    this._perguntaSelecionada,
    this._responder, {
    super.key,
  });

  bool get temPerguntaSelecionada {
    return _perguntaSelecionada < _perguntas.length;
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, Object>> _respostas = temPerguntaSelecionada
        ? _perguntas[_perguntaSelecionada].cast()['respostas']
        : [];

    return Column(
      children: [
        Questao(_perguntas[_perguntaSelecionada]['pergunta'].toString()),
        ..._respostas.map((resposta) {
          return Resposta(
            resposta['texto'].toString(),
            () => _responder(int.parse(resposta['pontuacao'].toString())),
          );
        }),
      ],
    );
  }
}
