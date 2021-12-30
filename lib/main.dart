import 'package:flutter/material.dart';
import 'package:flutter_tests/traveler/ui/screen/add_traveler_screen.dart';
import 'package:flutter_driver/driver_extension.dart';

void main() {
  enableFlutterDriverExtension();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      showPerformanceOverlay: false,
      home: AddTravelerScreen(),
    );
  }
}
