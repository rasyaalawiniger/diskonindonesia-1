import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primaryDark = Color(0xFF23282E);
  static const Color primaryLight = Color(0xFFF5F5F5);
  
  // Secondary Colors
  static const Color accent = Color(0xFF4CAF50);
  static const Color accentLight = Color(0xFF81C784);
  static const Color accentDark = Color(0xFF388E3C);
  
  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);
  
  // Neutral Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey100 = Color(0xFFF5F5F5);
  static const Color grey200 = Color(0xFFEEEEEE);
  static const Color grey300 = Color(0xFFE0E0E0);
  static const Color grey400 = Color(0xFFBDBDBD);
  static const Color grey500 = Color(0xFF9E9E9E);
  static const Color grey600 = Color(0xFF757575);
  static const Color grey700 = Color(0xFF616161);
  static const Color grey800 = Color(0xFF424242);
  static const Color grey900 = Color(0xFF212121);
  
  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryDark, Color(0xFF2C3238)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient accentGradient = LinearGradient(
    colors: [accent, accentLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

class AppSizes {
  // Padding & Margins
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
  
  // Border Radius
  static const double radiusXs = 4.0;
  static const double radiusSm = 8.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 24.0;
  
  // Icon Sizes
  static const double iconXs = 16.0;
  static const double iconSm = 20.0;
  static const double iconMd = 24.0;
  static const double iconLg = 32.0;
  static const double iconXl = 48.0;
  
  // Button Heights
  static const double buttonHeightSm = 36.0;
  static const double buttonHeightMd = 48.0;
  static const double buttonHeightLg = 56.0;
  
  // Card Dimensions
  static const double cardHeight = 120.0;
  static const double cardElevation = 4.0;
}

class AppStrings {
  // App Info
  static const String appName = 'DISKONINDONESIA';
  static const String appTagline = 'Loyalty Rewards Made Simple';
  
  // Authentication
  static const String login = 'Login';
  static const String register = 'Register';
  static const String logout = 'Logout';
  static const String email = 'Email';
  static const String password = 'Password';
  static const String confirmPassword = 'Confirm Password';
  static const String forgotPassword = 'Forgot Password?';
  static const String resetPassword = 'Reset Password';
  static const String name = 'Full Name';
  static const String phone = 'Phone Number';
  static const String referralCode = 'Referral Code (Optional)';
  
  // Navigation
  static const String home = 'Home';
  static const String rewards = 'Rewards';
  static const String coupons = 'Coupons';
  static const String profile = 'Profile';
  static const String merchant = 'Merchant';
  static const String admin = 'Admin';
  
  // Points & Rewards
  static const String points = 'Points';
  static const String balance = 'Balance';
  static const String cashback = 'Cashback';
  static const String redeem = 'Redeem';
  static const String redeemReward = 'Redeem Reward';
  static const String pointsBalance = 'Points Balance';
  static const String walletBalance = 'Wallet Balance';
  static const String earnPoints = 'Earn Points';
  static const String rewardCatalog = 'Reward Catalog';
  
  // Gamification
  static const String dailyCheckIn = 'Daily Check-in';
  static const String spinWheel = 'Spin the Wheel';
  static const String missions = 'Missions';
  static const String referFriends = 'Refer Friends';
  static const String streak = 'Streak';
  static const String congratulations = 'Congratulations!';
  
  // Transactions
  static const String transactions = 'Transactions';
  static const String transactionHistory = 'Transaction History';
  static const String amount = 'Amount';
  static const String date = 'Date';
  static const String status = 'Status';
  static const String pending = 'Pending';
  static const String completed = 'Completed';
  static const String cancelled = 'Cancelled';
  
  // Merchant
  static const String offers = 'Offers';
  static const String createOffer = 'Create Offer';
  static const String manageOffers = 'Manage Offers';
  static const String analytics = 'Analytics';
  static const String customers = 'Customers';
  
  // Error Messages
  static const String errorGeneral = 'Something went wrong. Please try again.';
  static const String errorNetwork = 'Network error. Please check your connection.';
  static const String errorInvalidCredentials = 'Invalid email or password.';
  static const String errorInsufficientPoints = 'Insufficient points for this reward.';
  static const String errorExpiredCoupon = 'This coupon has expired.';
  
  // Success Messages
  static const String successLogin = 'Login successful!';
  static const String successRegister = 'Registration successful!';
  static const String successRedemption = 'Reward redeemed successfully!';
  static const String successCheckIn = 'Daily check-in completed!';
  static const String successReferral = 'Referral bonus credited!';
}

class AppAssets {
  // Images
  static const String logo = 'assets/images/logo.png';
  static const String placeholder = 'assets/images/placeholder.png';
  static const String emptyState = 'assets/images/empty_state.png';
  
  // Animations
  static const String loadingAnimation = 'assets/animations/loading.json';
  static const String successAnimation = 'assets/animations/success.json';
  static const String spinWheelAnimation = 'assets/animations/spin_wheel.json';
  static const String confettiAnimation = 'assets/animations/confetti.json';
  
  // Icons
  static const String pointsIcon = 'assets/icons/points.svg';
  static const String cashbackIcon = 'assets/icons/cashback.svg';
  static const String rewardIcon = 'assets/icons/reward.svg';
  static const String couponIcon = 'assets/icons/coupon.svg';
}

enum UserRole {
  user,
  merchant,
  admin,
}

enum TransactionStatus {
  pending,
  verified,
  cancelled,
}

enum RedemptionStatus {
  pending,
  completed,
  cancelled,
}

enum MissionStatus {
  active,
  completed,
  failed,
  expired,
}

enum CouponType {
  percentage,
  fixed,
}

enum RewardType {
  voucher,
  item,
  credit,
}