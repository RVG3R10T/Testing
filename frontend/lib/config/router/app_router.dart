import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../screens/auth/login_screen.dart';
import '../../screens/auth/register_screen.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/company/company_profile_screen.dart';
import '../../screens/courses/course_list_screen.dart';
import '../../screens/courses/course_builder_screen.dart';
import '../../screens/assignments/assignments_screen.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/company/:companyId',
        builder: (context, state) {
          final companyId = state.pathParameters['companyId']!;
          return CompanyProfileScreen(companyId: companyId);
        },
      ),
      GoRoute(
        path: '/courses',
        builder: (context, state) => const CourseListScreen(),
      ),
      GoRoute(
        path: '/course/create',
        builder: (context, state) => const CourseBuilderScreen(),
      ),
      GoRoute(
        path: '/course/:courseId/edit',
        builder: (context, state) {
          final courseId = state.pathParameters['courseId']!;
          return CourseBuilderScreen(courseId: courseId);
        },
      ),
      GoRoute(
        path: '/assignments',
        builder: (context, state) => const AssignmentsScreen(),
      ),
    ],
  );
});
