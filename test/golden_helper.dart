import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

class GoldenSizeHelper {
  static final screens = screensWithoutAccessibility + accessibleScreens;

  static final a11yScreen = Device.phone.copyWith(name: 'a11y', textScale: 2);

  static final screensWithoutAccessibility = [
    Device.phone,
  ];

  static final accessibleScreens = [
    a11yScreen,
  ];

  static final semanticsScreen = Device.phone.copyWith(name: 'semantic');
}

class MaterialGolden extends StatelessWidget {

  final Widget child;

  const MaterialGolden({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SemanticsDebugger(
        labelStyle: TextStyle(
          fontFamily: Theme.of(context).textTheme.bodyText1?.fontFamily,
          color: Color(0xFF000000),
          fontSize: 10.0,
          height: 0.8,
        ),
        child: child);
  }
}
