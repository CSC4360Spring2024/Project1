import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../controllers/budget_setup_controller.dart';

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
        title: Text(
          'Budget Setup',
          style: GoogleFonts.kalam(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.teal[600],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 100.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Start Date: ${DateFormat.yMd().format(_controller.startDate)}',
                  style: GoogleFonts.lora(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                SizedBox(width: 8.0),
                IconButton(
                  icon: Icon(Icons.calendar_month),
                  onPressed: () async {
                    await _controller.selectStartDate(context);
                    setState(() {});
                  },
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'End Date: ${DateFormat.yMd().format(_controller.endDate)}',
                  style: GoogleFonts.lora(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                SizedBox(width: 8.0),
                IconButton(
                  icon: Icon(Icons.calendar_month),
                  onPressed: () async {
                    await _controller.selectEndDate(context);
                    setState(() {});
                  },
                ),
              ],
            ),
            SizedBox(height: 16.0),
            DropdownButtonFormField(
              value: _controller.selectedCategory,
              hint: Text('Category'),
              onChanged: (value) {
                setState(() {
                  _controller.selectedCategory = value.toString();
                });
              },
              items: ['Food', 'Transport', 'Shopping', 'Others']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: GoogleFonts.rubik(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _controller.amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Limit',
                labelStyle: GoogleFonts.rubik(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              style: GoogleFonts.rubik(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.tealAccent[400],
                  side: BorderSide(
                    color: Colors.black, 
                    width: 2.0
                  ),
                ),
                child: Text(
                  'Check Budget',
                  style: GoogleFonts.ibmPlexSansArabic(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                onPressed: () {
                  _controller.saveBudget(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
