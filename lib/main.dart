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
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Expense Tracker"),
          centerTitle: true,
        ),

        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [

              // STACK WIDGET
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 160,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),

                  Column(
                    children: [
                      const Icon(
                        Icons.account_balance_wallet,
                        size: 45,
                        color: Colors.white,
                      ),

                      const Text(
                        "Total Balance",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),

                      const Text(
                        "₹10,000",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // ROW WIDGET
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  // INCOME
                  Column(
                    children: [
                      const Icon(
                        Icons.arrow_downward,
                        size: 35,
                        color: Colors.green,
                      ),
                      const Text(
                        "Income",
                        style: TextStyle(fontSize: 18),
                      ),
                      const Text(
                        "₹15,000",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  // EXPENSE
                  Column(
                    children: [
                      const Icon(
                        Icons.arrow_upward,
                        size: 35,
                        color: Colors.red,
                      ),
                      const Text(
                        "Expense",
                        style: TextStyle(fontSize: 18),
                      ),
                      const Text(
                        "₹5,000",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 35),

              // TEXT WIDGET
              const Text(
                "Recent Expenses",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              // CONTAINER WIDGET
              Container(
                padding: const EdgeInsets.all(15),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.shopping_cart,
                      size: 30,
                    ),
                    SizedBox(width: 15),
                    Text(
                      "Shopping        ₹2,000",
                      style: TextStyle(fontSize: 17),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ELEVATED BUTTON
              ElevatedButton(
                onPressed: () {},
                child: const Text("Add Expense"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}