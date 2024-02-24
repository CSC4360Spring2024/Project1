import 'package:flutter/material.dart';
import 'expense_entry_screen.dart';
import 'budget_setup_screen.dart';
import 'reports_and_charts_screen.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text('Log Expense'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ExpenseEntryScreen()),
                );
              },
            ),
            ElevatedButton(
              child: Text('Budget Setup'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BudgetSetupScreen()),
                );
              },
            ),
            ElevatedButton(
              child: Text('Reports and Charts'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReportsAndChartsScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
