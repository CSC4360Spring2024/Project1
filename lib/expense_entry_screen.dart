import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'database_helper.dart';
import 'expense_model.dart';

class ExpenseEntryScreen extends StatefulWidget {
  @override
  _ExpenseEntryScreenState createState() => _ExpenseEntryScreenState();
}

class _ExpenseEntryScreenState extends State<ExpenseEntryScreen> {
  TextEditingController amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _selectedCategory = 'Food'; // Set an initial value
  TextEditingController notesController = TextEditingController();

  final dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Entry'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Amount'),
            ),
            SizedBox(height: 16.0),
            Row(
              children: <Widget>[
                Text('Date: ${DateFormat.yMd().format(_selectedDate)}'),
                SizedBox(width: 8.0),
                ElevatedButton(
                  child: Text('Select Date'),
                  onPressed: () async {
                    final DateTime picked = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate,
                      firstDate: DateTime(2015, 8),
                      lastDate: DateTime(2101),
                    ) ?? _selectedDate;
                    if (picked != null && picked != _selectedDate)
                      setState(() {
                        _selectedDate = picked;
                      });
                  },
                ),
              ],
            ),
            SizedBox(height: 16.0),
            DropdownButtonFormField(
              value: _selectedCategory,
              hint: Text('Category'),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value.toString();
                });
              },
              items: ['Food', 'Transport', 'Shopping', 'Others']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: notesController,
              decoration: InputDecoration(labelText: 'Notes'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              child: Text('Save Expense'),
              onPressed: () {
                _saveExpense();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _saveExpense() async {
    double amount = double.parse(amountController.text);
    String notes = notesController.text;

    Expense expense = Expense(
      amount: amount,
      date: _selectedDate,
      category: _selectedCategory,
      notes: notes,
    );

    await dbHelper.insertExpense(expense);

    // Clear the text fields after saving
    amountController.clear();
    notesController.clear();
    // Reset selected category
    setState(() {
      _selectedCategory = 'Food'; // Set it back to the initial value
    });

    // Navigate back to the previous screen
    Navigator.pop(context);
  }
}
