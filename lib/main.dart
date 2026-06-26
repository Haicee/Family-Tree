import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_router.dart';
import 'services/onboarding_service.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const ProviderScope(child: TreeFamiliaApp()));
}

class TreeFamiliaApp extends StatelessWidget {
  const TreeFamiliaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tree Familia',
      theme: AppTheme.lightTheme,
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: AppRouter.initial,
      debugShowCheckedModeBanner: false,
    );
  }
}

class InitialScreen extends ConsumerStatefulWidget {
  const InitialScreen({super.key});

  @override
  ConsumerState<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends ConsumerState<InitialScreen> {
  @override
  void initState() {
    super.initState();
    _checkOnboarding();
  }

  Future<void> _checkOnboarding() async {
    final hasSeenWelcome = await OnboardingService.hasSeenWelcome();
    if (mounted) {
      Navigator.pushReplacementNamed(
        context,
        hasSeenWelcome ? AppRouter.home : AppRouter.welcome,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: Color(0xFFD4A574),
        ),
      ),
    );
  }
}
