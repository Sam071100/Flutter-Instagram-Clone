import 'package:flutter/material.dart';

class NavScreen extends StatelessWidget {
  static const String routeName = '/nav';

  // we want the Nav screen to slide over the splash screen so instead of using material page route we have to use the Page Route builder in order to make the screen appear on top of the splash screen
  static Route route() {
    return PageRouteBuilder(
      settings: const RouteSettings(name: routeName),
      transitionDuration: const Duration(seconds: 0),
      pageBuilder: (_, __, ___) => NavScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('Nav Screen'),
    );
  }
}
