import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'database_helper.dart';
import 'expense_model.dart';
import 'expense_detail_screen.dart';

class ReportsAndChartsScreen extends StatefulWidget {
  @override
  _ReportsAndChartsScreenState createState() => _ReportsAndChartsScreenState();
}

class _ReportsAndChartsScreenState extends State<ReportsAndChartsScreen> {
  List<Expense> _expenseList = [];
  final _dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _getExpenses();
  }

  Future<void> _getExpenses() async {
    List<Expense> expenses = await _dbHelper.getExpenseList();
    setState(() {
      _expenseList = expenses;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reports and Charts'),
      ),
      body: _expenseList.isEmpty ? _buildEmptyState() : _buildCharts(),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Text('No expenses recorded.'),
    );
  }

  Widget _buildCharts() {
    Map<String, double> categoryTotalMap = _calculateCategoryTotal();
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
            itemCount: _expenseList.length,
            itemBuilder: (context, index) {
              Expense expense = _expenseList[index];
              return ListTile(
                title: Text(expense.category),
                subtitle: Text(
                    '\$${expense.amount.toStringAsFixed(2)} - ${expense.date.toString()}'),
                onTap: () {
                  _navigateToExpenseDetailScreen(expense);
                },
              );
            },
          ),
        ),
      ],
    );
  }

  void _navigateToExpenseDetailScreen(Expense expense) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExpenseDetailScreen(expense: expense),
      ),
    ).then((_) {
      _getExpenses();
    });
  }

  Map<String, double> _calculateCategoryTotal() {
    Map<String, double> categoryTotalMap = {};

    for (Expense expense in _expenseList) {
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
