import 'package:flutter/material.dart';

import 'package:expenses/models/transaction.dart' show Transaction;
import 'package:intl/intl.dart' show NumberFormat, DateFormat;

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    super.key,
    required this.brlFormatter,
    required this.indexTransaction,
    required this.onRemoveTransaction,
  });

  final NumberFormat brlFormatter;
  final Transaction indexTransaction;
  final void Function(String p1) onRemoveTransaction;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
              child: Text(brlFormatter.format(indexTransaction.value)),
            ),
          ),
        ),
        title: Text(
          indexTransaction.title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(DateFormat('d MMM y').format(indexTransaction.date)),
        trailing: MediaQuery.of(context).size.width > 480
            ? TextButton.icon(
                onPressed: () => onRemoveTransaction(indexTransaction.id),
                icon: const Icon(Icons.delete),
                label: Text(
                  "Excluir",
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              )
            : IconButton(
                onPressed: () => onRemoveTransaction(indexTransaction.id),
                icon: const Icon(Icons.delete),
                color: Theme.of(context).colorScheme.error,
              ),
      ),
    );
  }
}
