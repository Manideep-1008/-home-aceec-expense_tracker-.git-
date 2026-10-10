import 'package:flutter/material.dart';

void main() {
  runApp(const ExpenseTrackerApp());
}

// Experiment 6: Custom Theme
class ExpenseTrackerApp extends StatelessWidget {
  const ExpenseTrackerApp({super.key});

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
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
        ),
      ),
      home: const ExpenseHomePage(),
    );
  }
}

// Sample expense model
class Expense {
  final String title;
  final String category;
  final double amount;
  final IconData icon;

  const Expense({
    required this.title,
    required this.category,
    required this.amount,
    required this.icon,
  });
}

// Experiment 6: Reusable custom widget
class ExpenseCard extends StatelessWidget {
  final Expense expense;

  const ExpenseCard({
    super.key,
    required this.expense,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 6,
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(expense.icon),
        ),
        title: Text(
          expense.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(expense.category),
        trailing: Text(
          '₹${expense.amount.toStringAsFixed(2)}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),
      ),
    );
  }
}

// Reusable summary widget
class SummaryCard extends StatelessWidget {
  final double total;

  const SummaryCard({
    super.key,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.deepPurple.shade50,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'Total Expenses',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              '₹${total.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExpenseHomePage extends StatelessWidget {
  const ExpenseHomePage({super.key});

  final List<Expense> expenses = const [
    Expense(
      title: 'Lunch',
      category: 'Food',
      amount: 150,
      icon: Icons.restaurant,
    ),
    Expense(
      title: 'Bus Ticket',
      category: 'Travel',
      amount: 50,
      icon: Icons.directions_bus,
    ),
    Expense(
      title: 'Notebook',
      category: 'Education',
      amount: 80,
      icon: Icons.book,
    ),
    Expense(
      title: 'Snacks',
      category: 'Food',
      amount: 60,
      icon: Icons.fastfood,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final double total = expenses.fold(
      0,
      (sum, expense) => sum + expense.amount,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SummaryCard(total: total),
          const Padding(
            padding: EdgeInsets.all(12),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Recent Expenses',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                return ExpenseCard(
                  expense: expenses[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}