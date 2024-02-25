import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'expense_model.dart';

class ExpenseDetailScreen extends StatelessWidget {
  final Expense expense;
  final DatabaseHelper _dbHelper = DatabaseHelper();

  ExpenseDetailScreen({required this.expense});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Detail'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Category: ${expense.category}',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            Text(
              'Amount: \$${expense.amount.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            Text(
              'Date: ${expense.date.toString()}',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            Text(
              'Notes: ${expense.notes}',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _navigateToEditExpenseScreen(context);
                  },
                  child: Text('Edit'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _deleteExpense(context);
                  },
                  child: Text('Delete'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToEditExpenseScreen(BuildContext context) {
    // You can implement navigation to the edit expense screen here
    // For example:
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => EditExpenseScreen(expense: expense),
    //   ),
    // );
  }

  void _deleteExpense(BuildContext context) {
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
