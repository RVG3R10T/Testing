class Assignment {
  final int id;
  final int courseId;
  final int userId;
  final String courseTitle;
  final String? dueDate;
  final bool isCompleted;
  final int completionPercentage;
  final DateTime? completedAt;
  final DateTime createdAt;

  Assignment({
    required this.id,
    required this.courseId,
    required this.userId,
    required this.courseTitle,
    this.dueDate,
    this.isCompleted = false,
    this.completionPercentage = 0,
    this.completedAt,
    required this.createdAt,
  });

  factory Assignment.fromJson(Map<String, dynamic> json) {
    return Assignment(
      id: json['id'],
      courseId: json['course_id'],
      userId: json['user_id'],
      courseTitle: json['course_title'],
      dueDate: json['due_date'],
      isCompleted: json['is_completed'] ?? false,
      completionPercentage: json['completion_percentage'] ?? 0,
      completedAt: json['completed_at'] != null
          ? DateTime.parse(json['completed_at'])
          : null,
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'course_id': courseId,
      'user_id': userId,
      'course_title': courseTitle,
      'due_date': dueDate,
      'is_completed': isCompleted,
      'completion_percentage': completionPercentage,
      'completed_at': completedAt?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
    };
  }
}
