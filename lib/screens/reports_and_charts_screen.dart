import 'package:flutter/material.dart';
import '../controllers/reports_and_charts_controller.dart';

class ReportsAndChartsScreen extends StatefulWidget {
  @override
  _ReportsAndChartsScreenState createState() => _ReportsAndChartsScreenState();
}

class _ReportsAndChartsScreenState extends State<ReportsAndChartsScreen> {
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
        title: Text('Reports and Charts'),
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
