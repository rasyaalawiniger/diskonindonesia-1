class AppConfig {
  static const String appName = 'DISKONINDONESIA';
  static const String appVersion = '1.0.0';
  
  // Supabase Configuration
  static const String supabaseUrl = 'YOUR_SUPABASE_URL';
  static const String supabaseAnonKey = 'YOUR_SUPABASE_ANON_KEY';
  
  // API Endpoints
  static const String baseApiUrl = 'YOUR_SUPABASE_URL/rest/v1';
  
  // App Settings
  static const int pointsPerDollar = 1;
  static const int dailyCheckInPoints = 10;
  static const int referralBonusPoints = 100;
  static const int maxSpinPerDay = 1;
  static const int streakBonusThreshold = 7;
  static const int streakBonusPoints = 50;
  
  // Cashback Settings
  static const double defaultCashbackRate = 0.05; // 5%
  static const int cashbackVerificationDays = 7;
  
  // Mission Settings
  static const int missionCompletionBonus = 100;
  
  // Reward Settings
  static const int minRedemptionPoints = 100;
  
  // Security Settings
  static const int sessionTimeoutMinutes = 30;
  static const bool enableBiometricAuth = true;
  
  // Notification Settings
  static const bool enablePushNotifications = true;
  static const bool enableEmailNotifications = true;
  
  // UI Settings
  static const double borderRadius = 12.0;
  static const double cardElevation = 4.0;
  static const Duration animationDuration = Duration(milliseconds: 300);
}