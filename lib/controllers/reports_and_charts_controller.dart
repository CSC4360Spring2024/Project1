import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../database/database_helper.dart';
import '../models/expense_model.dart';
import '../expense_detail_screen.dart';

class ReportsAndChartsController {
  List<Expense> expenseList = [];
  final dbHelper = DatabaseHelper();

  Future<void> getExpenses() async {
    List<Expense> expenses = await dbHelper.getExpenseList();
    expenseList = expenses;
  }

  Widget buildEmptyState() {
    return Center(
      child: Text('No expenses recorded.'),
    );
  }

  Widget buildCharts(BuildContext context) {
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
                    '\$${expense.amount.toStringAsFixed(2)} - ${expense.date.toString()}'),
                onTap: () {
                  _navigateToExpenseDetailScreen(context, expense);
                },
              );
            },
          ),
        ),
      ],
    );
  }

  void _navigateToExpenseDetailScreen(BuildContext context, Expense expense) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExpenseDetailScreen(expense: expense),
      ),
    ).then((_) {
      getExpenses();
    });
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

class CategoryTotal {
  final String category;
  final double total;

  CategoryTotal(this.category, this.total);
}
