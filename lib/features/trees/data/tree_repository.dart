import 'package:drift/drift.dart';

import '../../../core/database/database.dart';

/// Data access for [Trees]. All operations run against the local SQLite
/// database — no network connection is involved.
class TreeRepository {
  TreeRepository(this._db);

  final AppDatabase _db;

  /// Emits the list of trees, most recently updated first, and re-emits
  /// whenever the underlying data changes.
  Stream<List<Tree>> watchTrees() {
    final query = _db.select(_db.trees)
      ..orderBy([
        (t) => OrderingTerm(expression: t.updatedAt, mode: OrderingMode.desc),
      ]);
    return query.watch();
  }

  Future<Tree> getTree(int id) {
    return (_db.select(_db.trees)..where((t) => t.id.equals(id))).getSingle();
  }

  Future<int> createTree({required String name, String? description}) {
    return _db.into(_db.trees).insert(
          TreesCompanion.insert(
            name: name,
            description: Value(description),
          ),
        );
  }

  Future<void> updateTree(
    int id, {
    required String name,
    String? description,
  }) {
    return (_db.update(_db.trees)..where((t) => t.id.equals(id))).write(
      TreesCompanion(
        name: Value(name),
        description: Value(description),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Deletes a tree. Members, relationships, photos, stories and events that
  /// belong to it are removed automatically via ON DELETE CASCADE.
  Future<void> deleteTree(int id) {
    return (_db.delete(_db.trees)..where((t) => t.id.equals(id))).go();
  }
}
