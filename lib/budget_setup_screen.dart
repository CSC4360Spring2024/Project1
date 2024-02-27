import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'controllers/budget_setup_controller.dart';

class BudgetSetupScreen extends StatefulWidget {
  @override
  _BudgetSetupScreenState createState() => _BudgetSetupScreenState();
}

class _BudgetSetupScreenState extends State<BudgetSetupScreen> {
  final BudgetSetupController _controller = BudgetSetupController();

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
              controller: _controller.titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _controller.amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Amount'),
            ),
            SizedBox(height: 16.0),
            Row(
              children: <Widget>[
                Text('Start Date: ${DateFormat.yMd().format(_controller.startDate)}'),
                SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: () {
                    _controller.selectStartDate(context);
                  },
                  child: Text('Select Date'),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              children: <Widget>[
                Text('End Date: ${DateFormat.yMd().format(_controller.endDate)}'),
                SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: () {
                    _controller.selectEndDate(context);
                  },
                  child: Text('Select Date'),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _controller.saveBudget(context);
              },
              child: Text('Save Budget'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
