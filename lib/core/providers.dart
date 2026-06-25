import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'database/database.dart';

/// The single app-wide database instance. Closed when the provider scope is
/// disposed.
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});
