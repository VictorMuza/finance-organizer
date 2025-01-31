import 'package:flutter/material.dart';
//import '../utils/navigation.dart'; // Importando a navegação personalizada

class AppDrawer extends StatelessWidget {
  final VoidCallback onAddExpense;
  final VoidCallback onAddIncome;

  const AppDrawer(
      {super.key, required this.onAddExpense, required this.onAddIncome});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Gestão Financeira',
                style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
          ListTile(
            title: const Text('Adicionar Despesa'),
            onTap: onAddExpense,
          ),
          ListTile(
            title: const Text('Adicionar Receita'),
            onTap: onAddIncome,
          ),
          ListTile(
            title: const Text('Configurações'),
            onTap: onAddIncome,
          ),
        ],
      ),
    );
  }
}
