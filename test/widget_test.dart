import 'package:drift/native.dart';
import 'package:family_tree/core/database/database.dart';
import 'package:family_tree/features/trees/data/tree_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late TreeRepository repo;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repo = TreeRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('TreeRepository', () {
    test('creates and reads back a tree', () async {
      final id = await repo.createTree(name: 'Santos', description: 'Main');
      final tree = await repo.getTree(id);

      expect(tree.name, 'Santos');
      expect(tree.description, 'Main');
    });

    test('watchTrees returns all created trees', () async {
      await repo.createTree(name: 'First');
      await repo.createTree(name: 'Second');

      final trees = await repo.watchTrees().first;

      expect(trees.length, 2);
      expect(trees.map((t) => t.name), containsAll(['First', 'Second']));
    });

    test('updateTree changes the name', () async {
      final id = await repo.createTree(name: 'Old');
      await repo.updateTree(id, name: 'New', description: null);

      final tree = await repo.getTree(id);
      expect(tree.name, 'New');
      expect(tree.description, isNull);
    });

    test('deleteTree removes the tree', () async {
      final id = await repo.createTree(name: 'Temp');
      await repo.deleteTree(id);

      final trees = await repo.watchTrees().first;
      expect(trees, isEmpty);
    });
  });
}
