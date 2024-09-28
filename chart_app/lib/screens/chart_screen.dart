import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'simple_bar_chart.dart'; // Ensure this import is correct

class ChartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chart Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SimpleBarChart(
          _createSampleData(),
        ),
      ),
    );
  }

  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final data = [
      OrdinalSales('2017', 5),
      OrdinalSales('2018', 25),
      OrdinalSales('2019', 100),
      OrdinalSales('2020', 75),
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
