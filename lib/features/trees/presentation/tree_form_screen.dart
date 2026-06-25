import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/database.dart';
import '../providers.dart';

/// Create a new tree or edit an existing one. Pass [tree] to edit.
class TreeFormScreen extends ConsumerStatefulWidget {
  const TreeFormScreen({super.key, this.tree});

  final Tree? tree;

  bool get isEditing => tree != null;

  @override
  ConsumerState<TreeFormScreen> createState() => _TreeFormScreenState();
}

class _TreeFormScreenState extends ConsumerState<TreeFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.tree?.name ?? '');
    _descriptionController =
        TextEditingController(text: widget.tree?.description ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);

    final repo = ref.read(treeRepositoryProvider);
    final name = _nameController.text.trim();
    final description = _descriptionController.text.trim();
    final descriptionValue = description.isEmpty ? null : description;

    try {
      if (widget.isEditing) {
        await repo.updateTree(
          widget.tree!.id,
          name: name,
          description: descriptionValue,
        );
      } else {
        await repo.createTree(name: name, description: descriptionValue);
      }
      if (mounted) Navigator.of(context).pop();
    } catch (error) {
      if (mounted) {
        setState(() => _saving = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not save tree: $error')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEditing ? 'Edit tree' : 'New tree'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nameController,
              autofocus: !widget.isEditing,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Tree name',
                hintText: 'e.g. The Santos Family',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              minLines: 3,
              maxLines: 6,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                labelText: 'Description (optional)',
                hintText: 'A short note about this branch of the family',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _saving ? null : _save,
              icon: _saving
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.save_outlined),
              label: Text(widget.isEditing ? 'Save changes' : 'Create tree'),
            ),
          ],
        ),
      ),
    );
  }
}
