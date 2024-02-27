import 'package:flutter/material.dart';
import '../database/budget_database_helper.dart';
import '../models/budget_model.dart';

class BudgetSetupController {
  final TextEditingController titleController = TextEditingController();
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
    String title = titleController.text;
    double amount = double.parse(amountController.text);

    Budget budget = Budget(
      title: title,
      amount: amount,
      startDate: startDate,
      endDate: endDate,
    );

    try {
      await dbHelper.insertBudget(budget);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Budget saved successfully'),
        ),
      );
      Navigator.pop(context);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to save budget: $error'),
        ),
      );
    }
  }

  void dispose() {
    titleController.dispose();
    amountController.dispose();
  }
}
