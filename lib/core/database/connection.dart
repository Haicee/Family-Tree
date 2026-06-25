import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

/// Opens the on-device SQLite database used by the app.
///
/// The database file lives in the application support directory so the data is
/// owned by the user and persists across app launches without any network
/// connection. [driftDatabase] handles native sqlite3 setup on each platform.
QueryExecutor openConnection() {
  return driftDatabase(name: 'tree_familia');
}
