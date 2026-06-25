import 'package:drift/drift.dart';

import 'connection.dart';
import 'tables.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [Trees, Members, Relationships, Photos, Stories, Events],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(openConnection());

  /// Constructor for tests, allowing an in-memory or custom executor.
  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
        },
        beforeOpen: (details) async {
          // Required for ON DELETE CASCADE / SET NULL to be enforced by SQLite.
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );
}
