class Admin {
  final String adminId;
  final String password;
  final String name;
  final int provinceId;
  final int districtId;
  final int localAuthorityId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Admin({
    required this.adminId,
    required this.password,
    required this.name,
    required this.provinceId,
    required this.districtId,
    required this.localAuthorityId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
      adminId: json['admin_id'] as String,
      password: json['password'] as String,
      name: json['name'] as String,
      provinceId: json['province_id'] as int,
      districtId: json['district_id'] as int,
      localAuthorityId: json['local_authority_id'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'admin_id': adminId,
      'password': password,
      'name': name,
      'province_id': provinceId,
      'district_id': districtId,
      'local_authority_id': localAuthorityId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class SuperAdmin {
  final String adminId;
  final String password;
  final DateTime createdAt;
  final DateTime updatedAt;

  SuperAdmin({
    required this.adminId,
    required this.password,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SuperAdmin.fromJson(Map<String, dynamic> json) {
    return SuperAdmin(
      adminId: json['admin_id'] as String,
      password: json['password'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'admin_id': adminId,
      'password': password,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

enum UserRole { admin, superAdmin }

class AuthenticatedUser {
  final String adminId;
  final String? name;
  final UserRole role;
  final int? provinceId;
  final int? districtId;
  final int? localAuthorityId;

  AuthenticatedUser({
    required this.adminId,
    this.name,
    required this.role,
    this.provinceId,
    this.districtId,
    this.localAuthorityId,
  });
}
