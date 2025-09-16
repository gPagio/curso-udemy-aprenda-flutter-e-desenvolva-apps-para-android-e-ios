import 'package:flutter/material.dart';

import 'package:expenses/components/transaction_user.dart';

void main() {
  runApp(ExpensesApp());
}

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Despesas Pessoais")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            child: Card(
              child: Text("Gráfico"),
              color: Colors.blue,
              elevation: 5,
            ),
          ),
          TransactionUser(),
        ],
      ),
    );
  }
}
