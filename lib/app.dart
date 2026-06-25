import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/trees/presentation/trees_list_screen.dart';

class TreeFamiliaApp extends StatelessWidget {
  const TreeFamiliaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tree Familia',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      home: const TreesListScreen(),
    );
  }
}
