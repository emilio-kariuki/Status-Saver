import 'package:flutter/material.dart';

import '../View/home.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings, {required BuildContext context}) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) =>  Home());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Error"),
        ),
        body: const Center(
          child: Text("Error"),
        ),
      );
    });
  }
}
