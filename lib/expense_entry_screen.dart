import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'controllers/expense_entry_controller.dart';

class ExpenseEntryScreen extends StatelessWidget {
  final ExpenseEntryController _controller = ExpenseEntryController();

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
              controller: _controller.amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Amount'),
            ),
            SizedBox(height: 16.0),
            Row(
              children: <Widget>[
                Text('Date: ${DateFormat.yMd().format(_controller.selectedDate)}'),
                SizedBox(width: 8.0),
                ElevatedButton(
                  child: Text('Select Date'),
                  onPressed: () {
                    _controller.selectDate(context);
                  },
                ),
              ],
            ),
            SizedBox(height: 16.0),
            DropdownButtonFormField(
              value: _controller.selectedCategory,
              hint: Text('Category'),
              onChanged: (value) {
                _controller.selectedCategory = value.toString();
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
              controller: _controller.notesController,
              decoration: InputDecoration(labelText: 'Notes'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              child: Text('Save Expense'),
              onPressed: () {
                _controller.saveExpense(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
