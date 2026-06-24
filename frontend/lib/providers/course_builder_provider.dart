import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../../models/module_item.dart';

// Course builder state
class CourseBuilderState {
  final String? courseId;
  final String title;
  final String description;
  final int companyId;
  final List<ModuleItem> modules;
  final bool isLoading;
  final String? error;
  final ModuleItem? selectedModule;

  CourseBuilderState({
    this.courseId,
    this.title = '',
    this.description = '',
    this.companyId = 1,
    this.modules = const [],
    this.isLoading = false,
    this.error,
    this.selectedModule,
  });

  CourseBuilderState copyWith({
    String? courseId,
    String? title,
    String? description,
    int? companyId,
    List<ModuleItem>? modules,
    bool? isLoading,
    String? error,
    ModuleItem? selectedModule,
  }) {
    return CourseBuilderState(
      courseId: courseId ?? this.courseId,
      title: title ?? this.title,
      description: description ?? this.description,
      companyId: companyId ?? this.companyId,
      modules: modules ?? this.modules,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      selectedModule: selectedModule ?? this.selectedModule,
    );
  }
}

// Course builder notifier
class CourseBuilderNotifier extends StateNotifier<CourseBuilderState> {
  CourseBuilderNotifier({String? courseId})
      : super(CourseBuilderState(courseId: courseId));

  void setTitle(String title) {
    state = state.copyWith(title: title);
  }

  void setDescription(String description) {
    state = state.copyWith(description: description);
  }

  void addModule(ModuleItem module) {
    final updatedModules = [...state.modules];
    // Assign order index
    module.orderIndex = updatedModules.length;
    updatedModules.add(module);
    state = state.copyWith(modules: updatedModules);
  }

  void updateModule(int index, ModuleItem updatedModule) {
    if (index >= 0 && index < state.modules.length) {
      final updatedModules = [...state.modules];
      updatedModules[index] = updatedModule;
      state = state.copyWith(modules: updatedModules);
    }
  }

  void deleteModule(int index) {
    if (index >= 0 && index < state.modules.length) {
      final updatedModules = [...state.modules];
      updatedModules.removeAt(index);
      // Update order indices
      for (int i = 0; i < updatedModules.length; i++) {
        updatedModules[i].orderIndex = i;
      }
      state = state.copyWith(modules: updatedModules);
    }
  }

  void reorderModules(int oldIndex, int newIndex) {
    final updatedModules = [...state.modules];
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final module = updatedModules.removeAt(oldIndex);
    updatedModules.insert(newIndex, module);

    // Update order indices
    for (int i = 0; i < updatedModules.length; i++) {
      updatedModules[i].orderIndex = i;
    }
    state = state.copyWith(modules: updatedModules);
  }

  void setSelectedModule(ModuleItem? module) {
    state = state.copyWith(selectedModule: module);
  }

  void setLoading(bool loading) {
    state = state.copyWith(isLoading: loading);
  }

  void setError(String? error) {
    state = state.copyWith(error: error);
  }

  void reset() {
    state = CourseBuilderState();
  }
}

final courseBuilderProvider =
    StateNotifierProvider.family<CourseBuilderNotifier, CourseBuilderState, String?>(
  (ref, courseId) {
    return CourseBuilderNotifier(courseId: courseId);
  },
);
