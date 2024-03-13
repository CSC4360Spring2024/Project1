import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../controllers/expense_entry_controller.dart';

class ExpenseEntryScreen extends StatefulWidget {
  @override
  _ExpenseEntryScreenState createState() => _ExpenseEntryScreenState();
}

class _ExpenseEntryScreenState extends State<ExpenseEntryScreen> {
  final ExpenseEntryController _controller = ExpenseEntryController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.teal[300],
      appBar: AppBar(
        title: Text(
          'Expense Entry',
          style: GoogleFonts.kalam(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.teal[600],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 100, left: 16.0, right: 16.0, bottom: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(width: 20.0),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Date: ${DateFormat.yMd().format(_controller.selectedDate)}',
                    style: GoogleFonts.lora(
                      color: Colors.black,
                      fontSize: 20,
                      //fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8.0),
                  IconButton(
                    icon: Icon(Icons.calendar_month),
                    onPressed: () async {
                      await _controller.selectDate(context);
                      setState(() {}); // Update the screen after date selection
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _controller.amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Amount',
                labelStyle: GoogleFonts.rubik(
                  color: Colors.black,
                  fontSize: 20,
                  //fontWeight: FontWeight.bold,
                ),
              ),
              style: GoogleFonts.rubik(
                color: Colors.black,
                fontSize: 20,
                //fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            DropdownButtonFormField(
              value: _controller.selectedCategory,
              hint: Text(
                'Category',
                style: GoogleFonts.rubik(
                  color: Colors.black,
                  fontSize: 20,
                  //fontWeight: FontWeight.bold,
                ),
              ),
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
                      //fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _controller.notesController,
              decoration: InputDecoration(
                labelText: 'Notes',
                labelStyle: GoogleFonts.rubik(
                  color: Colors.black,
                  fontSize: 20,
                  //fontWeight: FontWeight.bold,
                ),
              ),
              style: GoogleFonts.rubik(
                color: Colors.black,
                fontSize: 20,
                //fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.tealAccent[400],
                side: BorderSide(
                  color: Colors.black, 
                  width: 2.0
                ), // Add a black border
              ),
              child: Text(
                'Save Expense',
                style: GoogleFonts.ibmPlexSansArabic(
                  color: Colors.black,
                  fontSize: 20,
                  //fontWeight: FontWeight.bold,
                ),
              ),
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
