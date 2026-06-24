import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/assignment.dart';
import '../../services/api_client.dart';

final userAssignmentsProvider = FutureProvider.family<List<Assignment>, String>(
  (ref, userId) async {
    final apiClient = await ref.watch(apiClientProvider.future);
    final response = await apiClient.get(
      '/assignments/user/$userId',
      fromJson: (json) => (json as List).map((item) => Assignment.fromJson(item)).toList(),
    );
    return response;
  },
);

final createAssignmentProvider = StateNotifierProvider<CreateAssignmentNotifier, AsyncValue<Assignment>>(
  (ref) => CreateAssignmentNotifier(ref),
);

class CreateAssignmentNotifier extends StateNotifier<AsyncValue<Assignment>> {
  final Ref ref;

  CreateAssignmentNotifier(this.ref) : super(const AsyncValue.loading());

  Future<void> assignCourse({
    required int courseId,
    required int userId,
    String? dueDate,
  }) async {
    state = const AsyncValue.loading();
    try {
      final apiClient = await ref.read(apiClientProvider.future);
      final assignment = await apiClient.post<Assignment>(
        '/assignments',
        data: {
          'course_id': courseId,
          'user_id': userId,
          'due_date': dueDate,
        },
        fromJson: (json) => Assignment.fromJson(json),
      );
      state = AsyncValue.data(assignment);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final updateAssignmentProgressProvider = StateNotifierProvider<UpdateProgressNotifier, AsyncValue<Assignment>>(
  (ref) => UpdateProgressNotifier(ref),
);

class UpdateProgressNotifier extends StateNotifier<AsyncValue<Assignment>> {
  final Ref ref;

  UpdateProgressNotifier(this.ref) : super(const AsyncValue.loading());

  Future<void> updateProgress({
    required String assignmentId,
    required int completionPercentage,
    required bool isCompleted,
  }) async {
    state = const AsyncValue.loading();
    try {
      final apiClient = await ref.read(apiClientProvider.future);
      final assignment = await apiClient.put<Assignment>(
        '/assignments/$assignmentId/progress',
        data: {
          'completion_percentage': completionPercentage,
          'is_completed': isCompleted,
        },
        fromJson: (json) => Assignment.fromJson(json),
      );
      state = AsyncValue.data(assignment);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
