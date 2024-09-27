# Flutter-home_screen_chart_screen-app
In this assignment, I will create a simple Flutter app with two screens:  Home Screen: A basic screen with a button that navigates to the Chart Screen. Chart Screen: A screen that displays a chart using data from an API.

The following packages will be used:

go_router for navigation between the Home Screen and Chart Screen.
flutter_riverpod for state management, particularly to manage data fetched from an external API.
charts_flutter to display a bar chart or another type of chart on the Chart Screen.
You’ll:

Define two routes using go_router for navigating between the screens.
Use riverpod to fetch data from an API and manage state.
Display the fetched data using a chart (like a bar chart) on the Chart Screen.
Show proficiency in both frontend design (UI/UX) and backend logic (data fetching, state management).

Steps to Implement the Assignment:
Set up Flutter in VS Code (with Android Studio for emulator):

Ensure that Flutter SDK and Android Studio are installed.
Set up an emulator via Android Studio or connect a real device for testing.
Create the Flutter Project:

bash

flutter create chart_app
cd chart_app
Add Dependencies in pubspec.yaml: Open pubspec.yaml and add the following dependencies:

yaml

dependencies:
  flutter:
    sdk: flutter
  go_router: ^9.1.1
  flutter_riverpod: ^2.0.0
  charts_flutter: ^0.12.0
  http: ^0.14.0 # For API requests
Install Dependencies: After saving pubspec.yaml, run:

bash
Copy code
flutter pub get


Create Home Screen: Create a lib/screens/home_screen.dart file with the following code:

dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.go('/chart');
          },
          child: Text('Go to Chart Screen'),
        ),
      ),
    );
  }
}


Create Chart Screen: Create a lib/screens/chart_screen.dart file for displaying the chart:

dart

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'simple_bar_chart.dart'; // Import the chart widget

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
Create Simple Bar Chart Widget: Create lib/screens/simple_bar_chart.dart file for chart visualization:

dart
Copy code
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class SimpleBarChart extends StatelessWidget {
  final List<charts.Series<dynamic, String>> seriesList;
  final bool? animate;

  SimpleBarChart(this.seriesList, {this.animate});

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: animate,
    );
  }
}
Set up Routing with go_router: Update lib/main.dart to configure routes:

dart
Copy code
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'screens/home_screen.dart';
import 'screens/chart_screen.dart';

void main() {
  final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => HomeScreen(),
      ),
      GoRoute(
        path: '/chart',
        builder: (context, state) => ChartScreen(),
      ),
    ],
  );

  runApp(MyApp(router: router));
}

class MyApp extends StatelessWidget {
  final GoRouter router;
  MyApp({required this.router});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
    );
  }
}
Fetch Data Using Riverpod: In lib/providers/chart_data_provider.dart, create a provider to manage API data fetching:

dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final chartDataProvider = FutureProvider((ref) async {
  final response = await http.get(Uri.parse('https://api.example.com/data'));
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load chart data');
  }
});

Commands to Run the Project:

To clean the project:
bash
flutter clean

To fetch dependencies:
bash

flutter pub get
To run the project on a device or emulator:

bash
Copy code
flutter run
To run on Chrome:

bash

flutter run -d chrome
To check for outdated dependencies:

bash

flutter pub outdated


Final Output

Home Screen: Displays a button to navigate to the Chart Screen.
Chart Screen: Displays a bar chart with sample data or fetched API data.
Routing: You can switch between screens using go_router.
State Management: Data fetching for charts is managed using riverpod.

Summary
This assignment allows you to demonstrate knowledge of navigation, state management, data fetching, and chart visualization in Flutter. Ensure you have Flutter SDK installed with the necessary dependencies and follow the steps to create the app. Use the above commands to run and manage the project in VS Code.
