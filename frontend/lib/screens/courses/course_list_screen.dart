import 'package:flutter/material.dart';

class CourseListScreen extends StatelessWidget {
  const CourseListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Courses'),
      ),
      body: const Center(
        child: Text('Courses list coming soon'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/course/create'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
