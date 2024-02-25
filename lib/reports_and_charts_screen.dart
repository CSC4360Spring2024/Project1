import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'expense_model.dart';
import 'package:charts_flutter/flutter.dart' as charts;
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
      body: _expenseList.isEmpty ? _buildEmptyState() : _buildExpenseList(),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Text('No expenses recorded.'),
    );
  }

  Widget _buildExpenseList() {
    return ListView.builder(
      itemCount: _expenseList.length,
      itemBuilder: (context, index) {
        Expense expense = _expenseList[index];
        return ListTile(
          title: Text(expense.category),
          subtitle: Text('\$${expense.amount.toStringAsFixed(2)} - ${expense.date.toString()}'),
          onTap: () {
            _navigateToExpenseDetailScreen(expense);
          },
        );
      },
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
}
