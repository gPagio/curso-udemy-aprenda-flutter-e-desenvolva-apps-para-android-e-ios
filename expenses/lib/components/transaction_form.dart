import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double) onSubmit;

  const TransactionForm({required this.onSubmit, super.key});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();

  final valueController = TextEditingController();

  _submitForm() {
    final title = titleController.text.trim();
    final value = double.tryParse(valueController.text) ?? 0.0;

    if (title.isEmpty && value <= 0) return;

    widget.onSubmit(title, value);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              /* Underline para indicar que o parametro que a função precisa
               * receber não será usado, o que interessa é apenas o _submitForm
               * que está sendo executado*/
              onSubmitted: (_) => _submitForm(),
              decoration: InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: valueController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              /* Underline para indicar que o parametro que a função precisa
               * receber não será usado, o que interessa é apenas o _submitForm
               * que está sendo executado*/
              onSubmitted: (_) => _submitForm(),
              decoration: InputDecoration(labelText: 'Valor R\$'),
            ),
            TextButton(
              onPressed: () {
                _submitForm();
              },
              child: Text(
                'Nova Transação',
                style: TextStyle(color: Colors.purple),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
