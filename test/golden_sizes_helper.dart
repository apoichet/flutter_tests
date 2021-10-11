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
