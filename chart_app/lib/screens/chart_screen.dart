import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'simple_bar_chart.dart';
import 'package:go_router/go_router.dart';

class ChartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chart Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                context.go('/');
              },
              child: Text('Go to Home Screen'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: SimpleBarChart(
                _createSampleData(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final data = [
      OrdinalSales('2017', 450),
      OrdinalSales('2018', 678),
      OrdinalSales('2019', 698),
      OrdinalSales('2020', 784),
      OrdinalSales('2021', 884),
      OrdinalSales('2022', 684),
      OrdinalSales('2023', 984),
      OrdinalSales('2024', 765),
    ];

    return [
      charts.Series<OrdinalSales, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
