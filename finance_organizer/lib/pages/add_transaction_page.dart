import 'package:flutter/material.dart';

class AddTransactionPage extends StatelessWidget {
  final String title;
  final List<String> categories;
  final Function(Map<String, dynamic>) onAddTransaction;

  const AddTransactionPage({
    super.key,
    required this.title,
    required this.categories,
    required this.onAddTransaction,
  });

  @override
  Widget build(BuildContext context) {
    final categoryController = TextEditingController();
    final amountController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: categoryController,
              decoration: InputDecoration(labelText: 'Categoria'),
            ),
            TextField(
              controller: amountController,
              decoration: InputDecoration(labelText: 'Valor'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: () {
                final category = categoryController.text;
                final amount = double.tryParse(amountController.text) ?? 0;
                onAddTransaction({
                  'category': category,
                  'amount': amount,
                });
                Navigator.pop(context);
              },
              child: const Text('Adicionar Transação'),
            ),
          ],
        ),
      ),
    );
  }
}
