import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/database/database.dart';
import '../../core/providers.dart';
import 'data/tree_repository.dart';

final treeRepositoryProvider = Provider<TreeRepository>((ref) {
  return TreeRepository(ref.watch(databaseProvider));
});

/// Streams all family trees for the home screen.
final treesProvider = StreamProvider<List<Tree>>((ref) {
  return ref.watch(treeRepositoryProvider).watchTrees();
});
