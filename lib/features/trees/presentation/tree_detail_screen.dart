import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';
import 'tree_form_screen.dart';

/// Shows a single tree's details. Member management, visualization, photos,
/// stories and events are added in subsequent slices; this screen is the entry
/// point those features will hang off of.
class TreeDetailScreen extends ConsumerWidget {
  const TreeDetailScreen({super.key, required this.treeId});

  final int treeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final treeAsync = ref.watch(treeRepositoryProvider).getTree(treeId);

    return FutureBuilder(
      future: treeAsync,
      builder: (context, snapshot) {
        final tree = snapshot.data;
        return Scaffold(
          appBar: AppBar(
            title: Text(tree?.name ?? 'Tree'),
            actions: [
              if (tree != null)
                IconButton(
                  icon: const Icon(Icons.edit_outlined),
                  tooltip: 'Edit tree',
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => TreeFormScreen(tree: tree),
                    ),
                  ),
                ),
            ],
          ),
          body: tree == null
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    if (tree.description?.isNotEmpty == true) ...[
                      Text(
                        tree.description!,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 24),
                    ],
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Icon(
                              Icons.groups_outlined,
                              size: 48,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Family members coming soon',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'The next update adds members, relationships and '
                              'the interactive tree view.',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
