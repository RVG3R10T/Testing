class User {
  final String uid;
  final String email;
  final String firstName;
  final String lastName;
  final String? bio;
  final String? avatar;
  final int? companyId;
  final String role;

  User({
    required this.uid,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.bio,
    this.avatar,
    this.companyId,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json['uid'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      bio: json['bio'],
      avatar: json['avatar'],
      companyId: json['company_id'],
      role: json['role'] ?? 'user',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'bio': bio,
      'avatar': avatar,
      'company_id': companyId,
      'role': role,
    };
  }

  get fullName => '$firstName $lastName';
}
