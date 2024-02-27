import 'package:flutter/material.dart';
import 'controllers/dashboard_controller.dart';

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
                DashboardController.navigateToExpenseEntry(context);
              },
            ),
            ElevatedButton(
              child: Text('Budget Setup'),
              onPressed: () {
                DashboardController.navigateToBudgetSetup(context);
              },
            ),
            ElevatedButton(
              child: Text('Reports and Charts'),
              onPressed: () {
                DashboardController.navigateToReportsAndCharts(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
