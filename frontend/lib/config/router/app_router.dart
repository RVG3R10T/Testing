import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/auth_provider.dart';
import '../../screens/auth/login_screen.dart';
import '../../screens/auth/register_screen.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/company/company_profile_screen.dart';
import '../../screens/courses/course_list_screen.dart';
import '../../screens/courses/course_builder_screen.dart';
import '../../screens/assignments/assignments_screen.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/login',
    redirect: (context, state) {
      final isAuthenticated = authState.whenData((user) => user != null).value ?? false;
      final isLoggingIn = state.matchedLocation == '/login';
      final isRegistering = state.matchedLocation == '/register';

      if (!isAuthenticated && !isLoggingIn && !isRegistering) {
        return '/login';
      }

      if (isAuthenticated && (isLoggingIn || isRegistering)) {
        return '/home';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/company/:companyId',
        name: 'company',
        builder: (context, state) {
          final companyId = state.pathParameters['companyId']!;
          return CompanyProfileScreen(companyId: companyId);
        },
      ),
      GoRoute(
        path: '/courses',
        name: 'courses',
        builder: (context, state) => const CourseListScreen(),
      ),
      GoRoute(
        path: '/course/create',
        name: 'createCourse',
        builder: (context, state) => const CourseBuilderScreen(),
      ),
      GoRoute(
        path: '/course/:courseId/edit',
        name: 'editCourse',
        builder: (context, state) {
          final courseId = state.pathParameters['courseId']!;
          return CourseBuilderScreen(courseId: courseId);
        },
      ),
      GoRoute(
        path: '/assignments',
        name: 'assignments',
        builder: (context, state) => const AssignmentsScreen(),
      ),
    ],
  );
});
