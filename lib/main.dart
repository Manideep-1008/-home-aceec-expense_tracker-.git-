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
      home: const ExpenseHomePage(),
    );
  }
}

class ExpenseHomePage extends StatelessWidget {
  const ExpenseHomePage({super.key});

  @override
  Widget build(BuildContext context) {

    // MediaQuery
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    // Orientation
    Orientation orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Tracker"),
        centerTitle: true,
      ),

      body: LayoutBuilder(
        builder: (context, constraints) {

          // LayoutBuilder
          bool isTablet = constraints.maxWidth >= 600;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [

                // Screen information
                Text(
                  "Screen: ${width.toStringAsFixed(0)} × ${height.toStringAsFixed(0)}",
                  style: const TextStyle(fontSize: 16),
                ),

                const SizedBox(height: 15),

                Text(
                  orientation == Orientation.portrait
                      ? "Portrait Mode"
                      : "Landscape Mode",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                // Responsive Container using MediaQuery
                Container(
                  width: width * 0.8,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.account_balance_wallet,
                        size: 45,
                        color: Colors.white,
                      ),
                      Text(
                        "Total Balance",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "₹10,000",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // Expanded Widget
                Row(
                  children: [

                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        child: const Column(
                          children: [
                            Icon(
                              Icons.arrow_downward,
                              color: Colors.green,
                              size: 35,
                            ),
                            Text(
                              "Income",
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              "₹15,000",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        child: const Column(
                          children: [
                            Icon(
                              Icons.arrow_upward,
                              color: Colors.red,
                              size: 35,
                            ),
                            Text(
                              "Expense",
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              "₹5,000",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                // LayoutBuilder responsive text
                Text(
                  isTablet
                      ? "Tablet Layout"
                      : "Mobile Layout",
                  style: TextStyle(
                    fontSize: isTablet ? 30 : 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(15),
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
                        "Shopping     ₹2,000",
                        style: TextStyle(fontSize: 17),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Add Expense"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}