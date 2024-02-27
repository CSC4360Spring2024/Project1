import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/expense_model.dart';

class ExpenseDetailController {
  final Expense expense;
  final DatabaseHelper _dbHelper = DatabaseHelper();

  ExpenseDetailController({required this.expense});

  void navigateToEditExpenseScreen(BuildContext context) {
    // You can implement navigation to the edit expense screen here
    // For example:
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => EditExpenseScreen(expense: expense),
    //   ),
    // );
  }

  Future<void> deleteExpense(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Expense'),
        content: Text('Are you sure you want to delete this expense?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await _dbHelper.deleteExpense(expense.id!);
              Navigator.pop(context);
              Navigator.pop(context); // Pop twice to go back to the previous screen
            },
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }
}
