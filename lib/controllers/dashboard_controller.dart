import 'package:flutter/material.dart';
import '../screens/expense_entry_screen.dart';
import '../screens/budget_setup_screen.dart';
import '../screens/reports_and_charts_screen.dart';

class DashboardController {
  static void navigateToExpenseEntry(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ExpenseEntryScreen()),
    );
  }

  static void navigateToBudgetSetup(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BudgetSetupScreen()),
    );
  }

  static void navigateToReportsAndCharts(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ReportsAndChartsScreen()),
    );
  }
}
