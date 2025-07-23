class AppConfig {
  static const String appName = 'DISKONINDONESIA';
  static const String appVersion = '1.0.0';
  
  // Supabase Configuration
<<<<<<< HEAD
  static const String supabaseUrl = 'https://kxzcxxbzlxfeqxkybrfx.supabase.co';
  static const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imt4emN4eGJ6bHhmZXF4a3licmZ4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTMwNzg1NTQsImV4cCI6MjA2ODY1NDU1NH0.YMJCI8jXn6G7L3t-xuRs8KvSl1wjXFTR8uNLr84E5DU';
  
  // API Endpoints
  static const String baseApiUrl = 'https://kxzcxxbzlxfeqxkybrfx.supabase.co/rest/v1';
=======
  static const String supabaseUrl = 'https://your-project.supabase.co';
  static const String supabaseAnonKey = 'your-anon-key';
  
  // API Endpoints
  static const String baseApiUrl = 'https://your-project.supabase.co/rest/v1';
>>>>>>> d6a932b7853468b0894132a625c8ca3495c114bf
  
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