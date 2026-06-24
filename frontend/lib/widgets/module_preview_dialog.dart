import 'package:flutter/material.dart';

class ModulePreviewDialog extends StatelessWidget {
  final String title;
  final String content;
  final String contentType;

  const ModulePreviewDialog({
    Key? key,
    required this.title,
    required this.content,
    required this.contentType,
  }) : super(key: key);

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  contentType.toUpperCase(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              _buildContentPreview(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContentPreview(BuildContext context) {
    switch (contentType) {
      case 'video':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Video URL:'),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Text(
                content,
                style: const TextStyle(fontFamily: 'monospace'),
              ),
            ),
          ],
        );
      case 'image':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Image URL:'),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Text(
                content,
                style: const TextStyle(fontFamily: 'monospace'),
              ),
            ),
          ],
        );
      case 'link':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Link URL:'),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Text(
                content,
                style: const TextStyle(fontFamily: 'monospace'),
              ),
            ),
          ],
        );
      default:
        return Text(content);
    }
  }
}
