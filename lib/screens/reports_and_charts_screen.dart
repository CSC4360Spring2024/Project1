import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/reports_and_charts_controller.dart';
import '../utils/screens_statefulwidgets.dart';

class ReportsAndChartsScreenState extends State<ReportsAndChartsScreen> {
  final ReportsAndChartsController _controller = ReportsAndChartsController();

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    await _controller.getExpenses();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Reports and Charts',
          style: GoogleFonts.kalam(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.teal[600],
      ),
      body: _controller.expenseList.isEmpty
          ? _controller.buildEmptyState()
          : _controller.buildCharts(context, _updateExpenses), // Pass callback function
    );
  }

  void _updateExpenses() async {
    await _controller.getExpenses();
    setState(() {});
  }
}

