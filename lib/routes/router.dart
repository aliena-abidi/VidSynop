import 'package:flutter/material.dart';
import 'package:vidsynop/modules/modules.dart';

class MyRouter {
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Route Not Defined'),
        ),
      );
    });
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashPage.routeName:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case HomePage.routeName:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case MainScreen.routeName:
        return MaterialPageRoute(builder: (_) => const MainScreen());
      case SummaryPage.routeName:
        return MaterialPageRoute(builder: (_) => const SummaryPage());

      default:
        return _errorRoute();
    }
  }
}
