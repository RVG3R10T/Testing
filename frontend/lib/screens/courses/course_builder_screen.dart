import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/module_item.dart';
import '../../providers/course_builder_provider.dart';
import '../../widgets/module_editor_dialog.dart';
import '../../widgets/module_preview_card.dart';

class CourseBuilderScreen extends ConsumerStatefulWidget {
  final String? courseId;

  const CourseBuilderScreen({Key? key, this.courseId}) : super(key: key);

  @override
  ConsumerState<CourseBuilderScreen> createState() => _CourseBuilderScreenState();
}

class _CourseBuilderScreenState extends ConsumerState<CourseBuilderScreen> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  int? draggedIndex;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void _addModule() {
    showDialog(
      context: context,
      builder: (context) => ModuleEditorDialog(
        onSave: (module) {
          final notifier =
              ref.read(courseBuilderProvider(widget.courseId).notifier);
          notifier.addModule(module);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Module added successfully')),
          );
        },
      ),
    );
  }

  void _editModule(int index) {
    final state = ref.read(courseBuilderProvider(widget.courseId));
    final module = state.modules[index];

    showDialog(
      context: context,
      builder: (context) => ModuleEditorDialog(
        initialModule: module,
        onSave: (updatedModule) {
          final notifier =
              ref.read(courseBuilderProvider(widget.courseId).notifier);
          notifier.updateModule(index, updatedModule);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Module updated successfully')),
          );
        },
      ),
    );
  }

  void _deleteModule(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Module'),
        content: const Text(
            'Are you sure you want to delete this module? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final notifier =
                  ref.read(courseBuilderProvider(widget.courseId).notifier);
              notifier.deleteModule(index);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Module deleted')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _saveCourse() {
    final state = ref.read(courseBuilderProvider(widget.courseId));
    final title = titleController.text.trim();
    final description = descriptionController.text.trim();

    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a course title')),
      );
      return;
    }

    if (state.modules.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add at least one module')),
      );
      return;
    }

    // TODO: Save course to backend
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Course saved successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final courseBuilder = ref.watch(courseBuilderProvider(widget.courseId));

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.courseId != null ? 'Edit Course' : 'Create Course'),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: _saveCourse,
              icon: const Icon(Icons.save),
              label: const Text('Save Course'),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Course Details Section
            _buildSectionTitle(context, 'Course Details'),
            const SizedBox(height: 16),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Course Title',
                hintText: 'e.g., Company Onboarding',
                prefixIcon: const Icon(Icons.title),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                hintText: 'Briefly describe what this course is about',
                prefixIcon: const Icon(Icons.description),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              maxLines: 4,
            ),
            const SizedBox(height: 48),
            // Course Modules Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSectionTitle(context, 'Course Modules'),
                ElevatedButton.icon(
                  onPressed: _addModule,
                  icon: const Icon(Icons.add),
                  label: const Text('Add Module'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Modules List
            if (courseBuilder.modules.isEmpty)
              Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.auto_stories_outlined,
                      size: 64,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No modules yet',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.grey[600],
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Start building your course by adding modules with text, videos, images, or links.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                  ],
                ),
              )
            else
              ReorderableListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                onReorder: (oldIndex, newIndex) {
                  final notifier =
                      ref.read(courseBuilderProvider(widget.courseId).notifier);
                  notifier.reorderModules(oldIndex, newIndex);
                },
                children: List.generate(
                  courseBuilder.modules.length,
                  (index) {
                    final module = courseBuilder.modules[index];
                    return Container(
                      key: ValueKey(module.id ?? index),
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ModulePreviewCard(
                        module: module,
                        index: index,
                        onEdit: () => _editModule(index),
                        onDelete: () => _deleteModule(index),
                        isDragging: draggedIndex == index,
                      ),
                    );
                  },
                ),
              ),
            const SizedBox(height: 32),
            // Stats
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStat(
                    context,
                    label: 'Modules',
                    value: courseBuilder.modules.length.toString(),
                  ),
                  _buildStat(
                    context,
                    label: 'Duration',
                    value: '${courseBuilder.modules.length * 5} min',
                  ),
                  _buildStat(
                    context,
                    label: 'Content Types',
                    value: _countContentTypes(courseBuilder.modules).toString(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }

  Widget _buildStat(BuildContext context,
      {required String label, required String value}) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey,
              ),
        ),
      ],
    );
  }

  int _countContentTypes(List<ModuleItem> modules) {
    final types = <String>{};n    for (final module in modules) {
      types.add(module.contentType);
    }
    return types.length;
  }
}
