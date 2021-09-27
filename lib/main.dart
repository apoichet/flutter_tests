import 'package:flutter/material.dart';
import 'package:flutter_tests/traveler/ui/screen/add_traveler_screen.dart';

void main() {
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
      home: AddTravelerScreen(),
    );
  }
}
