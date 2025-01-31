import 'package:finance_organizer/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AddIncomeScreen extends StatelessWidget {
  const AddIncomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar Receita"),
      ),
      body: Center(
        child: Text("Tela de Adicionar Receita"),
      ),
    );
  }
}

void main() {
  runApp(FinanceApp());
}

class TransactionList extends StatelessWidget {
  const TransactionList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text("Transação $index"),
          subtitle: Text("Detalhes da transação $index"),
        );
      },
    );
  }
}

class FinanceApp extends StatelessWidget {
  const FinanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gestão Financeira"),
        centerTitle: true,
      ),
      drawer: AppDrawer(
        onAddExpense: () {},
        onAddIncome: () {},
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BalanceCard(),
            SizedBox(height: 20),
            Text("Gráfico de Gastos",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            SizedBox(height: 200, child: ExpenseChart()),
            SizedBox(height: 20),
            Text("Transações Recentes",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(child: TransactionList()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Wrap(
                children: [
                  ListTile(
                    leading: Icon(Icons.add_circle, color: Colors.green),
                    title: Text("Adicionar Receita"),
                    onTap: () {
                      Navigator.pop(context); // Fecha o modal
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddExpenseScreen()),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.remove_circle, color: Colors.red),
                    title: Text("Adicionar Despesa"),
                    onTap: () {
                      Navigator.pop(context); // Fecha o modal
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddIncomeScreen()),
                      );
                    },
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

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
            title: const Text('Configurações'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
            leading: Icon(Icons.settings),
          ),
        ],
      ),
    );
  }
}

class BalanceCard extends StatelessWidget {
  const BalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Saldo Atual",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("R\$ 5.000,00",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green)),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Entradas", style: TextStyle(color: Colors.green)),
                    Text("R\$ 7.500,00",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Saídas", style: TextStyle(color: Colors.red)),
                    Text("R\$ 2.500,00",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ExpenseChart extends StatelessWidget {
  const ExpenseChart({super.key});

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        sections: [
          PieChartSectionData(value: 40, title: "Moradia", color: Colors.blue),
          PieChartSectionData(
              value: 30, title: "Alimentação", color: Colors.green),
          PieChartSectionData(
              value: 15, title: "Transporte", color: Colors.orange),
          PieChartSectionData(value: 15, title: "Outros", color: Colors.red),
        ],
      ),
    );
  }
}

class AddExpenseScreen extends StatelessWidget {
  const AddExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Adicionar Despesa")),
      body: Center(child: Text("Tela para adicionar uma despesa")),
    );
  }
}
