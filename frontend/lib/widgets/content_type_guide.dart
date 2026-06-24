import 'package:flutter/material.dart';

class ContentTypeGuide extends StatelessWidget {
  const ContentTypeGuide({Key? key}) : super(key: key);

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
                'Content Types Guide',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 24),
              _buildContentTypeGuide(
                context,
                icon: Icons.description_outlined,
                title: '📝 Text',
                description: 'Written content, lessons, or instructions',
                example: 'e.g., "Welcome to our company. Here are...',
                color: Colors.grey,
              ),
              const SizedBox(height: 16),
              _buildContentTypeGuide(
                context,
                icon: Icons.play_circle_outline,
                title: '🎥 Video',
                description: 'Video lessons or demonstrations',
                example: 'e.g., https://youtube.com/watch?v=...',
                color: Colors.red,
              ),
              const SizedBox(height: 16),
              _buildContentTypeGuide(
                context,
                icon: Icons.image_outlined,
                title: '🖼️ Image',
                description: 'Visual content like diagrams or screenshots',
                example: 'e.g., https://example.com/image.jpg',
                color: Colors.orange,
              ),
              const SizedBox(height: 16),
              _buildContentTypeGuide(
                context,
                icon: Icons.link_outlined,
                title: '🔗 Link',
                description: 'External resources or reference materials',
                example: 'e.g., https://example.com/resource',
                color: Colors.blue,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Got it'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContentTypeGuide(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required String example,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              example,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
