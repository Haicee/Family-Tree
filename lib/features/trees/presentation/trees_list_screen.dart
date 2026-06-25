import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/database/database.dart';
import '../providers.dart';
import 'tree_detail_screen.dart';
import 'tree_form_screen.dart';

/// Home screen listing all family trees with create / edit / delete actions.
class TreesListScreen extends ConsumerWidget {
  const TreesListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final treesAsync = ref.watch(treesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tree Familia'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openForm(context),
        icon: const Icon(Icons.add),
        label: const Text('New tree'),
      ),
      body: treesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Could not load trees:\n$error')),
        data: (trees) {
          if (trees.isEmpty) {
            return const _EmptyState();
          }
          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
            itemCount: trees.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (context, index) => _TreeCard(tree: trees[index]),
          );
        },
      ),
    );
  }

  static Future<void> _openForm(BuildContext context, {Tree? tree}) {
    return Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => TreeFormScreen(tree: tree)),
    );
  }
}

class _TreeCard extends ConsumerWidget {
  const _TreeCard({required this.tree});

  final Tree tree;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final dateLabel = DateFormat.yMMMd().format(tree.updatedAt);

    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: theme.colorScheme.primaryContainer,
          child: Icon(
            Icons.park_outlined,
            color: theme.colorScheme.onPrimaryContainer,
          ),
        ),
        title: Text(
          tree.name,
          style: theme.textTheme.titleMedium,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          tree.description?.isNotEmpty == true
              ? tree.description!
              : 'Updated $dateLabel',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: PopupMenuButton<_TreeAction>(
          onSelected: (action) => _onAction(context, ref, action),
          itemBuilder: (context) => const [
            PopupMenuItem(
              value: _TreeAction.edit,
              child: ListTile(
                leading: Icon(Icons.edit_outlined),
                title: Text('Edit'),
                contentPadding: EdgeInsets.zero,
              ),
            ),
            PopupMenuItem(
              value: _TreeAction.delete,
              child: ListTile(
                leading: Icon(Icons.delete_outline),
                title: Text('Delete'),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => TreeDetailScreen(treeId: tree.id)),
        ),
      ),
    );
  }

  Future<void> _onAction(
    BuildContext context,
    WidgetRef ref,
    _TreeAction action,
  ) async {
    switch (action) {
      case _TreeAction.edit:
        await Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => TreeFormScreen(tree: tree)),
        );
      case _TreeAction.delete:
        await _confirmDelete(context, ref);
    }
  }

  Future<void> _confirmDelete(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete tree?'),
        content: Text(
          'This permanently removes "${tree.name}" and all of its members, '
          'photos, stories and events from this device.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton.tonal(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;
    await ref.read(treeRepositoryProvider).deleteTree(tree.id);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Deleted "${tree.name}"')),
      );
    }
  }
}

enum _TreeAction { edit, delete }

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.account_tree_outlined,
              size: 72,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text('No family trees yet', style: theme.textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(
              'Tap "New tree" to start preserving your family history.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
