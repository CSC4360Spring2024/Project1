import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'database_helper.dart';
import 'budget_model.dart';

class BudgetSetupScreen extends StatefulWidget {
  @override
  _BudgetSetupScreenState createState() => _BudgetSetupScreenState();
}

class _BudgetSetupScreenState extends State<BudgetSetupScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(Duration(days: 30)); // Default to 30 days from now
  final _dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Budget Setup'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Amount'),
            ),
            SizedBox(height: 16.0),
            Row(
              children: <Widget>[
                Text('Start Date: ${DateFormat.yMd().format(_startDate)}'),
                SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: () {
                    _selectStartDate(context);
                  },
                  child: Text('Select Date'),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              children: <Widget>[
                Text('End Date: ${DateFormat.yMd().format(_endDate)}'),
                SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: () {
                    _selectEndDate(context);
                  },
                  child: Text('Select Date'),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _saveBudget();
              },
              child: Text('Save Budget'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _startDate)
      setState(() {
        _startDate = picked;
      });
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _endDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _endDate)
      setState(() {
        _endDate = picked;
      });
  }

  void _saveBudget() {
    String title = _titleController.text;
    double amount = double.parse(_amountController.text);

    Budget budget = Budget(
      title: title,
      amount: amount,
      startDate: _startDate,
      endDate: _endDate,
    );

    _dbHelper.insertBudget(budget).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Budget saved successfully'),
        ),
      );
      Navigator.pop(context);
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to save budget: $error'),
        ),
      );
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }
}
