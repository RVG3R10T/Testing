import 'package:flutter/material.dart';
import '../../models/module_item.dart';

class ModulePreviewCard extends StatelessWidget {
  final ModuleItem module;
  final int index;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final bool isDragging;

  const ModulePreviewCard({
    Key? key,
    required this.module,
    required this.index,
    required this.onEdit,
    required this.onDelete,
    this.isDragging = false,
  }) : super(key: key);

  IconData _getContentIcon() {
    switch (module.contentType) {
      case 'video':
        return Icons.play_circle_outline;
      case 'image':
        return Icons.image_outlined;
      case 'link':
        return Icons.link_outlined;
      default:
        return Icons.description_outlined;
    }
  }

  Color _getContentColor() {
    switch (module.contentType) {
      case 'video':
        return Colors.red;
      case 'image':
        return Colors.orange;
      case 'link':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  String _getContentPreview() {
    switch (module.contentType) {
      case 'video':
        return 'Video';
      case 'image':
        return 'Image';
      case 'link':
        return 'Link';
      default:
        return module.content.length > 100
            ? '${module.content.substring(0, 100)}...'
            : module.content;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: isDragging ? 8 : 1,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border(
            left: BorderSide(
              color: _getContentColor(),
              width: 4,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Drag handle
              MouseRegion(
                cursor: SystemMouseCursors.grab,
                child: Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Icon(
                    Icons.drag_handle,
                    color: Colors.grey[400],
                  ),
                ),
              ),
              // Content icon
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _getContentColor().withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  _getContentIcon(),
                  color: _getContentColor(),
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              // Module info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${index + 1}. ${module.title}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _getContentPreview(),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              // Action buttons
              IconButton(
                icon: const Icon(Icons.edit_outlined),
                tooltip: 'Edit',
                onPressed: onEdit,
                color: Theme.of(context).primaryColor,
              ),
              IconButton(
                icon: const Icon(Icons.delete_outlined),
                tooltip: 'Delete',
                onPressed: onDelete,
                color: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
