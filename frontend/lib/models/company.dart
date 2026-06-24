class Company {
  final int id;
  final String name;
  final String? description;
  final String? logo;
  final String? website;
  final String ownerId;
  final DateTime createdAt;

  Company({
    required this.id,
    required this.name,
    this.description,
    this.logo,
    this.website,
    required this.ownerId,
    required this.createdAt,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      logo: json['logo'],
      website: json['website'],
      ownerId: json['owner_id'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'logo': logo,
      'website': website,
      'owner_id': ownerId,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
