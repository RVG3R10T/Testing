import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Training Platform'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome!',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 24),
            _buildDashboardCard(
              context,
              title: 'My Courses',
              icon: Icons.school,
              onTap: () => Navigator.pushNamed(context, '/courses'),
            ),
            const SizedBox(height: 16),
            _buildDashboardCard(
              context,
              title: 'My Assignments',
              icon: Icons.assignment,
              onTap: () => Navigator.pushNamed(context, '/assignments'),
            ),
            const SizedBox(height: 16),
            _buildDashboardCard(
              context,
              title: 'Company Profile',
              icon: Icons.business,
              onTap: () => Navigator.pushNamed(context, '/company/1'),
            ),
            const SizedBox(height: 16),
            _buildDashboardCard(
              context,
              title: 'Create Course',
              icon: Icons.add_circle,
              onTap: () => Navigator.pushNamed(context, '/course/create'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Icon(icon, size: 40, color: Theme.of(context).primaryColor),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              Icon(Icons.arrow_forward_ios,
                  size: 20, color: Theme.of(context).primaryColor),
            ],
          ),
        ),
      ),
    );
  }
}
