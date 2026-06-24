import 'package:flutter/material.dart';

class CourseBuilderScreen extends StatefulWidget {
  final String? courseId;

  const CourseBuilderScreen({Key? key, this.courseId}) : super(key: key);

  @override
  State<CourseBuilderScreen> createState() => _CourseBuilderScreenState();
}

class _CourseBuilderScreenState extends State<CourseBuilderScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final List<Map<String, String>> modules = [];

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.courseId != null ? 'Edit Course' : 'Create Course'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveCourse,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Course Details',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                hintText: 'Course Title',
                labelText: 'Title',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                hintText: 'Course Description',
                labelText: 'Description',
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Course Modules',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                ElevatedButton.icon(
                  onPressed: _addModule,
                  icon: const Icon(Icons.add),
                  label: const Text('Add Module'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            modules.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'No modules added yet. Click "Add Module" to start building your course.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: modules.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Card(
                          child: ListTile(
                            leading: ReorderableDragStartListener(
                              index: index,
                              child: const Icon(Icons.drag_handle),
                            ),
                            title: Text(modules[index]['title'] ?? ''),
                            subtitle: Text(modules[index]['type'] ?? ''),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => _removeModule(index),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }

  void _addModule() {
    // TODO: Implement module creation dialog
    print('Add module');
  }

  void _removeModule(int index) {
    setState(() {
      modules.removeAt(index);
    });
  }

  void _saveCourse() {
    // TODO: Implement course save logic
    print('Save course: ${titleController.text}');
  }
}
