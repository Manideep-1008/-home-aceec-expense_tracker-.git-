import 'package:flutter/material.dart';

void main() {
  runApp(const ExpenseTrackerApp());
}

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
      ),
      home: const ExpenseAnimationPage(),
    );
  }
}

class ExpenseAnimationPage extends StatefulWidget {
  const ExpenseAnimationPage({super.key});

  @override
  State<ExpenseAnimationPage> createState() =>
      _ExpenseAnimationPageState();
}

class _ExpenseAnimationPageState
    extends State<ExpenseAnimationPage> {
  bool _expanded = false;
  bool _showDetails = true;

  final List<Map<String, dynamic>> _expenses = [
    {
      'title': 'Lunch',
      'category': 'Food',
      'amount': 150.0,
      'icon': Icons.restaurant,
    },
    {
      'title': 'Bus Ticket',
      'category': 'Travel',
      'amount': 50.0,
      'icon': Icons.directions_bus,
    },
    {
      'title': 'Notebook',
      'category': 'Education',
      'amount': 80.0,
      'icon': Icons.book,
    },
  ];

  double get _total {
    return _expenses.fold(
      0.0,
      (sum, expense) => sum + (expense['amount'] as double),
    );
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
            const Text(
              'My Expenses',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Experiment 8: AnimatedContainer
            GestureDetector(
              onTap: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                width: double.infinity,
                height: _expanded ? 180 : 120,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: _expanded
                      ? Colors.deepPurple
                      : Colors.deepPurple.shade300,
                  borderRadius: BorderRadius.circular(
                    _expanded ? 30 : 16,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Total Expenses',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '₹${_total.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (_expanded)
                      const Text(
                        'Tap to collapse',
                        style: TextStyle(color: Colors.white70),
                      ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Experiment 8: AnimatedOpacity
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _showDetails = !_showDetails;
                  });
                },
                icon: Icon(
                  _showDetails
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
                label: Text(
                  _showDetails
                      ? 'Hide Expense Details'
                      : 'Show Expense Details',
                ),
              ),
            ),

            const SizedBox(height: 16),

            AnimatedOpacity(
              opacity: _showDetails ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 500),
              child: IgnorePointer(
                ignoring: !_showDetails,
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Recent Expenses',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    ..._expenses.map((expense) {
                      return Card(
                        child: ListTile(
                          leading: Icon(
                            expense['icon'] as IconData,
                            color: Colors.deepPurple,
                          ),
                          title: Text(expense['title'] as String),
                          subtitle: Text(
                            expense['category'] as String,
                          ),
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
            ),
          ],
        ),
      ),
    );
  }
}