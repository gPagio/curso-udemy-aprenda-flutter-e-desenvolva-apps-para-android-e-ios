import 'package:flutter/material.dart';
import 'package:shop/providers/counter_provider.dart' show CounterProvider;

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Exemplo Contador')),
      body: Column(
        children: [
          Text(
            CounterProvider.of(context)?.state.value.toString() ?? '0',
            style: TextStyle(fontSize: 48),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                CounterProvider.of(context)?.state.increment();
              });
            },
            icon: Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                CounterProvider.of(context)?.state.decrement();
              });
            },
            icon: Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
