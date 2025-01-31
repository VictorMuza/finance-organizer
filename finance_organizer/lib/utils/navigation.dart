import 'package:flutter/material.dart';
import '../pages/add_transaction_page.dart'; // Importando a página de transação

class Navigation {
  static void navigateToTransactionPage(
    BuildContext context,
    String title,
    List<String> categories,
    Function(Map<String, dynamic>) onAddTransaction,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddTransactionPage(
          title: title,
          categories: categories,
          onAddTransaction: onAddTransaction,
        ),
      ),
    );
  }
}
