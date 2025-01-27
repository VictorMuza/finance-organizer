import 'package:flutter/material.dart';

import 'pages/SettingsPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestão Financeira',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> _expenses = [];
  final List<Map<String, dynamic>> _incomes = [];

  void _addTransaction(
      {required Map<String, dynamic> transaction,
      required List<Map<String, dynamic>> list}) {
    setState(() {
      list.add(transaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gestão Financeira')),
      drawer: AppDrawer(
        onAddExpense: () => _navigateToTransactionPage(
          context,
          'Despesa',
          ['Alimentação', 'Transporte', 'Lazer', 'Educação', 'Saúde'],
          (transaction) =>
              _addTransaction(transaction: transaction, list: _expenses),
        ),
        onAddIncome: () => _navigateToTransactionPage(
          context,
          'Receita',
          ['Salário', 'Investimentos', 'Freelance', 'Prêmios', 'Outros'],
          (transaction) =>
              _addTransaction(transaction: transaction, list: _incomes),
        ),
      ),
      body: FinancialDashboard(expenses: _expenses, incomes: _incomes),
    );
  }

  void _navigateToTransactionPage(
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

class AppDrawer extends StatelessWidget {
  final VoidCallback onAddExpense;
  final VoidCallback onAddIncome;

  const AppDrawer({
    super.key,
    required this.onAddExpense,
    required this.onAddIncome,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text('Menu',
                style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
          _buildDrawerItem(
              context, Icons.home, 'Home', () => Navigator.pop(context)),
          _buildDrawerItem(
              context, Icons.add_circle, 'Inserir Despesa', onAddExpense),
          _buildDrawerItem(
              context, Icons.attach_money, 'Inserir Receita', onAddIncome),
          _buildDrawerItem(
            context,
            Icons.settings,
            'Configurações',
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsPage()),
            ),
          ),
          _buildDrawerItem(context, Icons.contact_page, 'Contato',
              () => Navigator.pop(context)),
          _buildDrawerItem(
              context, Icons.logout, 'Sair', () => Navigator.pop(context)),
        ],
      ),
    );
  }

  ListTile _buildDrawerItem(
      BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }
}

class FinancialDashboard extends StatelessWidget {
  final List<Map<String, dynamic>> expenses;
  final List<Map<String, dynamic>> incomes;

  const FinancialDashboard(
      {super.key, required this.expenses, required this.incomes});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTransactionSection('Últimas Receitas', incomes, Colors.green),
          const SizedBox(height: 20),
          _buildTransactionSection('Últimas Despesas', expenses, Colors.red),
        ],
      ),
    );
  }

  Widget _buildTransactionSection(
      String title, List<Map<String, dynamic>> transactions, Color iconColor) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          transactions.isEmpty
              ? Center(
                  child: Text('Nenhuma $title registrada.',
                      style: const TextStyle(fontSize: 16)),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: transactions.length,
                  itemBuilder: (context, index) {
                    final transaction = transactions[index];
                    return Card(
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading: Icon(Icons.attach_money, color: iconColor),
                        title: Text(transaction['description']),
                        subtitle: Text('Categoria: ${transaction['category']}'),
                        trailing: Text(
                          'R\$ ${transaction['value'].toStringAsFixed(2)}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }
}

class AddTransactionPage extends StatefulWidget {
  final Function(Map<String, dynamic>) onAddTransaction;
  final String title;
  final List<String> categories;

  const AddTransactionPage({
    super.key,
    required this.onAddTransaction,
    required this.title,
    required this.categories,
  });

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  final _formKey = GlobalKey<FormState>();
  late String _description;
  late double _value;
  late String _category;

  @override
  void initState() {
    super.initState();
    _category = widget.categories.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Inserir ${widget.title}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTextInput('Descrição', (value) => _description = value),
              _buildTextInput(
                  'Valor (R\$)', (value) => _value = double.parse(value),
                  keyboardType: TextInputType.number),
              DropdownButtonFormField<String>(
                value: _category,
                decoration: const InputDecoration(labelText: 'Categoria'),
                items: widget.categories.map((category) {
                  return DropdownMenuItem(
                      value: category, child: Text(category));
                }).toList(),
                onChanged: (value) => setState(() => _category = value!),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextInput(String label, Function(String) onSaved,
      {TextInputType? keyboardType}) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      keyboardType: keyboardType,
      validator: (value) =>
          value == null || value.isEmpty ? 'Por favor, insira $label.' : null,
      onSaved: (value) => onSaved(value!),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      widget.onAddTransaction({
        'description': _description,
        'value': _value,
        'category': _category
      });
      Navigator.pop(context);
    }
  }
}
