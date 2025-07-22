
class UserModel {
  final String userId;
  final String email;
  final String name;
  final String? phone;
  final String referralCode;
  final int pointsBalance;
  final double walletBalance;
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
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['user_id'] as String,
      email: json['email'] as String,
      name: json['nama'] as String,
      phone: json['telepon'] as String?,
      referralCode: json['kode_referral'] as String,
      pointsBalance: json['saldo_poin'] as int,
      walletBalance: (json['saldo_dompet'] as num).toDouble(),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'email': email,
      'nama': name,
      'telepon': phone,
      'kode_referral': referralCode,
      'saldo_poin': pointsBalance,
      'saldo_dompet': walletBalance,
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
      createdAt,
      updatedAt,
    );
  }

  @override
  String toString() {
    return 'UserModel(userId: $userId, email: $email, name: $name, phone: $phone, referralCode: $referralCode, pointsBalance: $pointsBalance, walletBalance: $walletBalance, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}