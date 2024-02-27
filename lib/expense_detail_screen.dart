import 'package:flutter/material.dart';
import 'models/expense_model.dart';
import 'controllers/expense_detail_controller.dart';

class ExpenseDetailScreen extends StatelessWidget {
  final Expense expense;
  final ExpenseDetailController _controller;

  ExpenseDetailScreen({required this.expense})
      : _controller = ExpenseDetailController(expense: expense);

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
                    _controller.navigateToEditExpenseScreen(context);
                  },
                  child: Text('Edit'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _controller.deleteExpense(context);
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
}
