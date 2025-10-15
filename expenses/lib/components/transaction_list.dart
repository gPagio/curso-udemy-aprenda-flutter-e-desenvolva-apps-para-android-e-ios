import 'package:flutter/material.dart';

import 'package:expenses/components/transaction_item.dart' show TransactionItem;
import 'package:expenses/models/transaction.dart' show Transaction;
import 'package:intl/intl.dart' show NumberFormat;

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;

  final void Function(String) onRemoveTransaction;

  static final brlFormatter = NumberFormat.currency(
    locale: 'pt_BR',
    symbol: 'R\$',
  );

  const TransactionList(
    this._transactions, {
    required this.onRemoveTransaction,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return _transactions.isEmpty
        ? LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    "Nenhuma transação cadastrada!",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
          )
        : ListView.builder(
            itemCount: _transactions.length,
            itemBuilder: (ctx, index) {
              final Transaction indexTransaction = _transactions[index];
              return TransactionItem(
                brlFormatter: brlFormatter,
                indexTransaction: indexTransaction,
                onRemoveTransaction: onRemoveTransaction,
              );
            },
          );
  }
}
