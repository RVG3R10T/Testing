import 'package:flutter/material.dart';

class ModuleItem {
  final String? id;
  final String title;
  final String content;
  final String contentType; // text, video, image, link
  int orderIndex;
  final DateTime? createdAt;

  ModuleItem({
    this.id,
    required this.title,
    required this.content,
    required this.contentType,
    required this.orderIndex,
    this.createdAt,
  });

  ModuleItem copyWith({
    String? id,
    String? title,
    String? content,
    String? contentType,
    int? orderIndex,
    DateTime? createdAt,
  }) {
    return ModuleItem(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      contentType: contentType ?? this.contentType,
      orderIndex: orderIndex ?? this.orderIndex,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'content_type': contentType,
      'order_index': orderIndex,
      'created_at': createdAt?.toIso8601String(),
    };
  }

  factory ModuleItem.fromJson(Map<String, dynamic> json) {
    return ModuleItem(
      id: json['id']?.toString(),
      title: json['title'],
      content: json['content'],
      contentType: json['content_type'],
      orderIndex: json['order_index'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }
}
