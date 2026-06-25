import 'package:flutter/material.dart';

/// Material 3 theme for Tree Familia. A warm green seed evokes the
/// "family tree" / growth theme of the app.
class AppTheme {
  static const Color _seed = Color(0xFF2E7D4F);

  static ThemeData light() => _build(Brightness.light);
  static ThemeData dark() => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final scheme = ColorScheme.fromSeed(
      seedColor: _seed,
      brightness: brightness,
    );
    return ThemeData(
      colorScheme: scheme,
      useMaterial3: true,
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surfaceContainer,
        elevation: 0,
        centerTitle: false,
      ),
      cardTheme: const CardThemeData(
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.zero,
      ),
    );
  }
}
