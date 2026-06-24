import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/auth_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUserAsync = ref.watch(currentUserProvider);
    final authState = ref.watch(authStateProvider);

    // Show loading state
    if (currentUserAsync is AsyncLoading || authState is AsyncLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // Show error state
    if (currentUserAsync is AsyncError) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              const Text('Error loading user profile'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => context.go('/login'),
                child: const Text('Back to Login'),
              ),
            ],
          ),
        ),
      );
    }

    final currentUser = currentUserAsync.value;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Training Platform'),
        elevation: 0,
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: const Text('Profile'),
                onTap: () => context.push('/profile'),
              ),
              PopupMenuItem(
                child: const Text('Logout'),
                onTap: () => _handleLogout(context, ref),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome, ${currentUser?.firstName}!',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      currentUser?.email ?? '',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                    if (currentUser?.role != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Chip(
                          label: Text(currentUser!.role.toUpperCase()),
                          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'Quick Actions',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            // Dashboard Cards
            _buildDashboardCard(
              context,
              title: 'My Courses',
              icon: Icons.school,
              subtitle: 'Browse all your courses',
              onTap: () => context.go('/courses'),
            ),
            const SizedBox(height: 16),
            _buildDashboardCard(
              context,
              title: 'My Assignments',
              icon: Icons.assignment,
              subtitle: 'View assigned courses',
              onTap: () => context.go('/assignments'),
            ),
            const SizedBox(height: 16),
            _buildDashboardCard(
              context,
              title: 'Company Profile',
              icon: Icons.business,
              subtitle: 'View company details',
              onTap: () => context.push('/company/1'),
            ),
            if (currentUser?.role == 'admin' || currentUser?.role == 'instructor')
              Column(
                children: [
                  const SizedBox(height: 16),
                  _buildDashboardCard(
                    context,
                    title: 'Create Course',
                    icon: Icons.add_circle,
                    subtitle: 'Build a new training course',
                    onTap: () => context.go('/course/create'),
                  ),
                ],
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
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  size: 32,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 18,
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleLogout(BuildContext context, WidgetRef ref) async {
    final logoutNotifier = ref.read(logoutNotifierProvider.notifier);
    await logoutNotifier.logout();
    if (context.mounted) {
      context.go('/login');
    }
  }
}
