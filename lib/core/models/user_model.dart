import '../utils/constants.dart';

class UserModel {
  final String userId;
  final String email;
  final String name;
  final String? phone;
  final String referralCode;
  final int pointsBalance;
  final double walletBalance;
  final UserRole role;
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserModel({
    required this.userId,
    required this.email,
    required this.name,
    this.phone,
    required this.referralCode,
    required this.pointsBalance,
    required this.walletBalance,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['user_id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String?,
      referralCode: json['referral_code'] as String,
      pointsBalance: json['points_balance'] as int,
      walletBalance: (json['wallet_balance'] as num).toDouble(),
      role: UserRole.values.firstWhere(
        (e) => e.name == json['role'],
        orElse: () => UserRole.user,
      ),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'email': email,
      'name': name,
      'phone': phone,
      'referral_code': referralCode,
      'points_balance': pointsBalance,
      'wallet_balance': walletBalance,
      'role': role.name,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  UserModel copyWith({
    String? userId,
    String? email,
    String? name,
    String? phone,
    String? referralCode,
    int? pointsBalance,
    double? walletBalance,
    UserRole? role,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      referralCode: referralCode ?? this.referralCode,
      pointsBalance: pointsBalance ?? this.pointsBalance,
      walletBalance: walletBalance ?? this.walletBalance,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserModel &&
        other.userId == userId &&
        other.email == email &&
        other.name == name &&
        other.phone == phone &&
        other.referralCode == referralCode &&
        other.pointsBalance == pointsBalance &&
        other.walletBalance == walletBalance &&
        other.role == role &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return Object.hash(
      userId,
      email,
      name,
      phone,
      referralCode,
      pointsBalance,
      walletBalance,
      role,
      createdAt,
      updatedAt,
    );
  }

  @override
  String toString() {
    return 'UserModel(userId: $userId, email: $email, name: $name, phone: $phone, referralCode: $referralCode, pointsBalance: $pointsBalance, walletBalance: $walletBalance, role: $role, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}