import 'package:flutter/material.dart';

class AssignmentsScreen extends StatelessWidget {
  const AssignmentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Assignments'),
      ),
      body: const Center(
        child: Text('Assignments list coming soon'),
      ),
    );
  }
}
