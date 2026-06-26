import 'package:flutter/material.dart';
import 'main.dart';
import 'pages/home_page.dart';
import 'pages/welcome_screen.dart';

class AppRouter {
  static const String initial = '/';
  static const String welcome = '/welcome';
  static const String home = '/home';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initial:
        return MaterialPageRoute(
          builder: (_) => const InitialScreen(),
          settings: settings,
        );
      case welcome:
        return MaterialPageRoute(
          builder: (_) => const WelcomeScreen(),
          settings: settings,
        );
      case home:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Route not found'))),
        );
    }
  }
}
