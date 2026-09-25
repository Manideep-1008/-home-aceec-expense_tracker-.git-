import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ExpenseProvider(),
      child: const ExpenseTrackerApp(),
    ),
  );
}

// PROVIDER
class ExpenseProvider extends ChangeNotifier {
  double balance = 10000;

  void addExpense(double amount) {
    balance -= amount;
    notifyListeners();
  }
}

// STATELESS WIDGET
class ExpenseTrackerApp extends StatelessWidget {
  const ExpenseTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Expense Tracker",
      home: const ExpenseHomePage(),
    );
  }
}

// STATEFUL WIDGET
class ExpenseHomePage extends StatefulWidget {
  const ExpenseHomePage({super.key});

  @override
  State<ExpenseHomePage> createState() => _ExpenseHomePageState();
}

class _ExpenseHomePageState extends State<ExpenseHomePage> {
  int expenseCount = 0;

  // setState()
  void addExpense() {
    setState(() {
      expenseCount++;
    });

    // Provider
    Provider.of<ExpenseProvider>(
      context,
      listen: false,
    ).addExpense(500);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ExpenseProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Tracker"),
        centerTitle: true,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Icon(
              Icons.account_balance_wallet,
              size: 70,
              color: Colors.blue,
            ),

            const SizedBox(height: 20),

            const Text(
              "Total Balance",
              style: TextStyle(fontSize: 20),
            ),

            Text(
              "₹${provider.balance.toStringAsFixed(0)}",
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "Shopping Expense",
              style: TextStyle(fontSize: 20),
            ),

            const SizedBox(height: 10),

            Text(
              "Expenses Added: $expenseCount",
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: addExpense,
              child: const Text("Add Expense ₹500"),
            ),
          ],
        ),
      ),
    );
  }
}