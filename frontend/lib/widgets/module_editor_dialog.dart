import 'package:flutter/material.dart';
import '../../models/module_item.dart';

class ModuleEditorDialog extends StatefulWidget {
  final ModuleItem? initialModule;
  final Function(ModuleItem) onSave;

  const ModuleEditorDialog({
    Key? key,
    this.initialModule,
    required this.onSave,
  }) : super(key: key);

  @override
  State<ModuleEditorDialog> createState() => _ModuleEditorDialogState();
}

class _ModuleEditorDialogState extends State<ModuleEditorDialog> {
  late TextEditingController titleController;
  late TextEditingController contentController;
  late String selectedType;
  String? titleError;
  String? contentError;

  final contentTypes = ['text', 'video', 'image', 'link'];
  final contentTypeLabels = {
    'text': '📝 Text',
    'video': '🎥 Video',
    'image': '🖼️ Image',
    'link': '🔗 Link',
  };

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.initialModule?.title ?? '');
    contentController =
        TextEditingController(text: widget.initialModule?.content ?? '');
    selectedType = widget.initialModule?.contentType ?? 'text';
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  bool _validate() {
    bool isValid = true;
    titleError = null;
    contentError = null;

    if (titleController.text.isEmpty) {
      titleError = 'Title is required';
      isValid = false;
    }

    if (contentController.text.isEmpty) {
      contentError = 'Content is required';
      isValid = false;
    }

    setState(() {});
    return isValid;
  }

  void _handleSave() {
    if (!_validate()) return;

    final module = ModuleItem(
      id: widget.initialModule?.id,
      title: titleController.text,
      content: contentController.text,
      contentType: selectedType,
      orderIndex: widget.initialModule?.orderIndex ?? 0,
      createdAt: widget.initialModule?.createdAt,
    );

    widget.onSave(module);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.initialModule != null ? 'Edit Module' : 'Add Module',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 24),
              // Title Field
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Module Title',
                  hintText: 'e.g., Introduction to Training',
                  errorText: titleError,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onChanged: (_) => setState(() => titleError = null),
              ),
              const SizedBox(height: 16),
              // Content Type Selection
              Text(
                'Content Type',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: contentTypes.map((type) {
                  return ChoiceChip(
                    label: Text(contentTypeLabels[type]!),
                    selected: selectedType == type,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() => selectedType = type);
                      }
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              // Content Field
              TextField(
                controller: contentController,
                decoration: InputDecoration(
                  labelText: _getContentLabel(),
                  hintText: _getContentHint(),
                  errorText: contentError,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                maxLines: selectedType == 'text' ? 8 : 3,
                onChanged: (_) => setState(() => contentError = null),
              ),
              const SizedBox(height: 24),
              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: _handleSave,
                    child: const Text('Save Module'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getContentLabel() {
    switch (selectedType) {
      case 'video':
        return 'Video URL';
      case 'image':
        return 'Image URL';
      case 'link':
        return 'Link URL';
      default:
        return 'Content';
    }
  }

  String _getContentHint() {
    switch (selectedType) {
      case 'video':
        return 'e.g., https://youtube.com/watch?v=...';
      case 'image':
        return 'e.g., https://example.com/image.jpg';
      case 'link':
        return 'e.g., https://example.com/resource';
      default:
        return 'Enter your content here';
    }
  }
}
