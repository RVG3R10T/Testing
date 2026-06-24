import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/course.dart';
import '../../services/api_client.dart';

final courseProvider = FutureProvider.family<Course, String>(
  (ref, courseId) async {
    final apiClient = await ref.watch(apiClientProvider.future);
    final response = await apiClient.get(
      '/courses/$courseId',
      fromJson: (json) => Course.fromJson(json),
    );
    return response;
  },
);

final createCourseProvider = StateNotifierProvider<CreateCourseNotifier, AsyncValue<Course>>(
  (ref) => CreateCourseNotifier(ref),
);

class CreateCourseNotifier extends StateNotifier<AsyncValue<Course>> {
  final Ref ref;

  CreateCourseNotifier(this.ref) : super(const AsyncValue.loading());

  Future<void> createCourse({
    required String title,
    String? description,
    required int companyId,
    String? thumbnail,
  }) async {
    state = const AsyncValue.loading();
    try {
      final apiClient = await ref.read(apiClientProvider.future);
      final course = await apiClient.post<Course>(
        '/courses',
        data: {
          'title': title,
          'description': description,
          'company_id': companyId,
          'thumbnail': thumbnail,
        },
        fromJson: (json) => Course.fromJson(json),
      );
      state = AsyncValue.data(course);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final addModuleProvider = StateNotifierProvider<AddModuleNotifier, AsyncValue<CourseModule>>(
  (ref) => AddModuleNotifier(ref),
);

class AddModuleNotifier extends StateNotifier<AsyncValue<CourseModule>> {
  final Ref ref;

  AddModuleNotifier(this.ref) : super(const AsyncValue.loading());

  Future<void> addModule({
    required String courseId,
    required String title,
    required String content,
    required String contentType,
    required int orderIndex,
  }) async {
    state = const AsyncValue.loading();
    try {
      final apiClient = await ref.read(apiClientProvider.future);
      final module = await apiClient.post<CourseModule>(
        '/courses/$courseId/modules',
        data: {
          'title': title,
          'content': content,
          'content_type': contentType,
          'order_index': orderIndex,
        },
        fromJson: (json) => CourseModule.fromJson(json),
      );
      state = AsyncValue.data(module);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
