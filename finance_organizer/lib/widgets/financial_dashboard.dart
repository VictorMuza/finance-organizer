import 'package:flutter/material.dart';

class FinancialDashboard extends StatelessWidget {
  final List<Map<String, dynamic>> expenses;
  final List<Map<String, dynamic>> incomes;

  const FinancialDashboard(
      {super.key, required this.expenses, required this.incomes});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Resumo Financeiro',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        Expanded(
          child: ListView(
            children: [
              _buildSection('Despesas', expenses),
              _buildSection('Receitas', incomes),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSection(String title, List<Map<String, dynamic>> items) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: items
              .map((item) => Text('${item['category']}: ${item['amount']}'))
              .toList(),
        ),
      ),
    );
  }
}
