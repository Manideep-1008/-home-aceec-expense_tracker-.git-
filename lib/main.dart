import 'package:flutter/material.dart';

void main() {
  runApp(const ExpenseApp());
}

class ExpenseApp extends StatelessWidget {
  const ExpenseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: const AddExpensePage(),
    );
  }
}

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({super.key});

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  String _category = 'Food';
  final List<String> _categories = [
    'Food',
    'Travel',
    'Education',
    'Shopping',
    'Other',
  ];

  final List<Map<String, dynamic>> _expenses = [];

  double get _total {
    return _expenses.fold(
      0.0,
      (sum, expense) => sum + (expense['amount'] as double),
    );
  }

  void _addExpense() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _expenses.add({
          'title': _titleController.text.trim(),
          'amount': double.parse(_amountController.text.trim()),
          'category': _category,
        });

        _titleController.clear();
        _amountController.clear();
        _category = 'Food';
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Expense added successfully!'),
        ),
      );
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add New Expense',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),

            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Expense Title',
                      hintText: 'Example: Lunch',
                      prefixIcon: Icon(Icons.edit),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter expense title';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    controller: _amountController,
                    keyboardType:
                        const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Amount (₹)',
                      prefixIcon: Icon(Icons.currency_rupee),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter amount';
                      }

                      final amount = double.tryParse(value.trim());

                      if (amount == null || !amount.isFinite) {
                        return 'Enter a valid number';
                      }

                      if (amount <= 0) {
                        return 'Amount must be greater than zero';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  DropdownButtonFormField<String>(
                    value: _category,
                    decoration: const InputDecoration(
                      labelText: 'Category',
                      prefixIcon: Icon(Icons.category),
                      border: OutlineInputBorder(),
                    ),
                    items: _categories.map((category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _category = value;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _addExpense,
                      icon: const Icon(Icons.add),
                      label: const Text('Add Expense'),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Text(
              'Total: ₹${_total.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              'Expense List',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            if (_expenses.isEmpty)
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text('No expenses added yet.'),
              ),

            ..._expenses.map((expense) {
              return Card(
                child: ListTile(
                  leading: const Icon(
                    Icons.receipt_long,
                    color: Colors.deepPurple,
                  ),
                  title: Text(expense['title'] as String),
                  subtitle: Text(expense['category'] as String),
                  trailing: Text(
                    '₹${(expense['amount'] as double).toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}