class CourseModule {
  final int? id;
  final int courseId;
  final String title;
  final String content;
  final String contentType; // text, video, image, link
  final int orderIndex;

  CourseModule({
    this.id,
    required this.courseId,
    required this.title,
    required this.content,
    required this.contentType,
    required this.orderIndex,
  });

  factory CourseModule.fromJson(Map<String, dynamic> json) {
    return CourseModule(
      id: json['id'],
      courseId: json['course_id'],
      title: json['title'],
      content: json['content'],
      contentType: json['content_type'],
      orderIndex: json['order_index'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'course_id': courseId,
      'title': title,
      'content': content,
      'content_type': contentType,
      'order_index': orderIndex,
    };
  }
}

class Course {
  final int? id;
  final String title;
  final String? description;
  final int companyId;
  final String creatorId;
  final String? thumbnail;
  final bool isPublished;
  final List<CourseModule> modules;
  final DateTime? createdAt;

  Course({
    this.id,
    required this.title,
    this.description,
    required this.companyId,
    required this.creatorId,
    this.thumbnail,
    this.isPublished = false,
    this.modules = const [],
    this.createdAt,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      companyId: json['company_id'],
      creatorId: json['creator_id'],
      thumbnail: json['thumbnail'],
      isPublished: json['is_published'] ?? false,
      modules: (json['modules'] as List?)
          ?.map((m) => CourseModule.fromJson(m))
          .toList() ??
          [],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'company_id': companyId,
      'creator_id': creatorId,
      'thumbnail': thumbnail,
      'is_published': isPublished,
      'modules': modules.map((m) => m.toJson()).toList(),
      'created_at': createdAt?.toIso8601String(),
    };
  }
}
