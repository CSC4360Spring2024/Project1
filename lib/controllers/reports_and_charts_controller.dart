import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';
import '../database/expense_database_helper.dart';
import '../models/expense_model.dart';
import '../screens/expense_detail_screen.dart';
import '../utils/category_total.dart';

class ReportsAndChartsController {
  List<Expense> expenseList = [];
  final dbHelper = ExpenseDatabaseHelper();

  Future<void> getExpenses() async {
    List<Expense> expenses = await dbHelper.getExpenseList();
    expenseList = expenses;
  }

  Widget buildEmptyState() {
    return Center(
      child: Text('No expenses recorded.'),
    );
  }

  Widget buildCharts(BuildContext context, VoidCallback updateExpenses) { // Accept the callback function
    Map<String, double> categoryTotalMap = _calculateCategoryTotal(expenseList);
    List<charts.Series<CategoryTotal, String>> seriesList = [
      charts.Series(
        id: 'CategoryTotal',
        data: categoryTotalMap.entries
            .map((entry) => CategoryTotal(entry.key, entry.value))
            .toList(),
        domainFn: (CategoryTotal categoryTotal, _) => categoryTotal.category,
        measureFn: (CategoryTotal categoryTotal, _) => categoryTotal.total,
      )
    ];

    return Column(
      children: [
        SizedBox(
          height: 300,
          child: charts.BarChart(
            seriesList,
            animate: true,
            vertical: false,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: expenseList.length,
            itemBuilder: (context, index) {
              Expense expense = expenseList[index];
              return ListTile(
                title: Text(expense.category),
                subtitle: Text(
                    '\$${expense.amount.toStringAsFixed(2)} - ${DateFormat.yMd().format(expense.date)}'),
                onTap: () {
                  _navigateToExpenseDetailScreen(context, expense, updateExpenses); // Pass the callback function
                },
              );
            },
          ),
        ),
      ],
    );
  }

  void _navigateToExpenseDetailScreen(BuildContext context, Expense expense, VoidCallback updateExpenses) { // Accept the callback function
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExpenseDetailScreen(expense: expense, updateExpenses: updateExpenses), // Pass the callback function
      ),
    );
  }

  Map<String, double> _calculateCategoryTotal(List<Expense> expenses) {
    Map<String, double> categoryTotalMap = {};

    for (Expense expense in expenses) {
      if (categoryTotalMap.containsKey(expense.category)) {
        categoryTotalMap[expense.category] =
            (categoryTotalMap[expense.category] ?? 0) + expense.amount;
      } else {
        categoryTotalMap[expense.category] = expense.amount;
      }
    }

    return categoryTotalMap;
  }
}
