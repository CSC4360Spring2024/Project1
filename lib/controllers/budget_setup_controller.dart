import 'package:flutter/material.dart';
import '../database/budget_database_helper.dart';
import '../models/budget_model.dart';

class BudgetSetupController {
  String selectedCategory = 'Food'; // Set an initial value
  final TextEditingController amountController = TextEditingController();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(Duration(days: 30)); // Default to 30 days from now
  final BudgetDatabaseHelper dbHelper = BudgetDatabaseHelper();

  Future<void> selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != startDate) {
      startDate = picked;
    }
  }

  Future<void> selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: endDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != endDate) {
      endDate = picked;
    }
  }

  Future<void> saveBudget(BuildContext context) async {
    double amount = double.parse(amountController.text);

    Budget budget = Budget(
      category: selectedCategory,
      amount: amount,
      startDate: startDate,
      endDate: endDate,
    );

    await dbHelper.insertBudget(budget);

    // Clear the text fields after saving
    amountController.clear();
    // Reset selected category
    selectedCategory = 'Food'; // Set it back to the initial value

    // Navigate back to the previous screen
    Navigator.pop(context);
  }
}
