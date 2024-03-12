import 'package:flutter/material.dart';
import '../controllers/dashboard_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double buttonHeight = 60;
    final double buttonWidth = 115;
    return Scaffold(
      backgroundColor: Colors.teal[300],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Welcome to Our Expense Tracker Application",
              style: GoogleFonts.caveat(
                color: Colors.white,
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(width: 5.0, color: Colors.white),
          ),
        ),
        child: BottomAppBar(
          color: Colors.teal[800],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(buttonWidth, buttonHeight),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  side: const BorderSide(
                    width: 2.0,
                    color: Colors.black,
                  ),
                ),
                child: Text(
                  'Log\nExpense',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.kalam(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  DashboardController.navigateToExpenseEntry(context);
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(buttonWidth, buttonHeight),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  side: const BorderSide(
                    width: 2.0,
                    color: Colors.black,
                  ),
                ),
                child: Text(
                  'Budget\nSetup',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.kalam(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  DashboardController.navigateToBudgetSetup(context);
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(buttonWidth, buttonHeight),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  side: const BorderSide(
                    width: 2.0,
                    color: Colors.black,
                  ),
                ),
                child: Text(
                  'Reports\nand Charts',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.kalam(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  DashboardController.navigateToReportsAndCharts(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
