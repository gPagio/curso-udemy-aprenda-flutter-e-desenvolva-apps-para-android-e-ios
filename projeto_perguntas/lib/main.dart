import 'package:flutter/material.dart';

import './resposta.dart';
import './questao.dart';

main() => runApp(PerguntaApp());

class _PerguntaAppState extends State<PerguntaApp> {
  final List<Map<String, Object>> perguntas = [
    {
      'pergunta': 'Qual é a sua cor favorita?',
      'respostas': ['Preto', 'Vermelho', 'Verde', 'Branco'],
    },
    {
      'pergunta': 'Qual é o seu animal favorito?',
      'respostas': ['Coelho', 'Cobra', 'Elefante', 'Leão'],
    },
    {
      'pergunta': 'Quantos mundiais tem o Palmeiras?',
      'respostas': ['Zero', '0 x 1', 'Quem é Palmeiras?', 'Kkkkkkkk'],
    },
  ];

  var _perguntaSelecionada = 0;

  void _responder() {
    setState(() {
      if (_perguntaSelecionada + 1 == perguntas.length) {
        _perguntaSelecionada = 0;
      } else {
        _perguntaSelecionada++;
      }
    });

    print('Pergunta Respondida!');
    print('Pergunta Selecionada $_perguntaSelecionada');
  }

  @override
  Widget build(BuildContext context) {

    List<String> respostasTexto = perguntas[_perguntaSelecionada].cast()['respostas'];

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Perguntas')),
        body: Column(
          children: [
            Questao(perguntas[_perguntaSelecionada]['pergunta'].toString()),
            ...respostasTexto.map((resposta) => Resposta(resposta, _responder))
          ],
        ),
      ),
    );
  }
}

class PerguntaApp extends StatefulWidget {
  const PerguntaApp({super.key});

  @override
  _PerguntaAppState createState() {
    return _PerguntaAppState();
  }
}
