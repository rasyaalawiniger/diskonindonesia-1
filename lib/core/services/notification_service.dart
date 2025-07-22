import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timezone/timezone.dart' as tz;

final notificationServiceProvider = Provider<NotificationService>((ref) {
  return NotificationService();
});

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initializationSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    // Request permissions for iOS
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      await _notifications
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    }
  }

  static void _onNotificationTapped(NotificationResponse response) {
    // Handle notification tap
    debugPrint('Notification tapped: ${response.payload}');
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
    NotificationImportance importance = NotificationImportance.high,
  }) async {
    final androidDetails = AndroidNotificationDetails(
      'diskonindonesia_channel',
      'DISKONINDONESIA Notifications',
      channelDescription: 'Notifications for loyalty rewards and updates',
      importance: _mapImportance(importance),
      priority: Priority.high,
      showWhen: true,
      icon: '@mipmap/ic_launcher',
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    final notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notifications.show(
      id,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
    String? payload,
    NotificationImportance importance = NotificationImportance.high,
  }) async {
    final androidDetails = AndroidNotificationDetails(
      'diskonindonesia_scheduled',
      'DISKONINDONESIA Scheduled',
      channelDescription: 'Scheduled notifications for reminders',
      importance: _mapImportance(importance),
      priority: Priority.high,
      showWhen: true,
      icon: '@mipmap/ic_launcher',
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    final notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notifications.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      notificationDetails,
      payload: payload,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  Future<void> showDailyCheckInReminder() async {
    await showNotification(
      id: 1001,
      title: 'Daily Check-in Available!',
      body: 'Don\'t forget to claim your daily points in DISKONINDONESIA',
      payload: 'daily_checkin',
    );
  }

  Future<void> showPointsEarned(int points) async {
    await showNotification(
      id: 1002,
      title: 'Points Earned!',
      body: 'You earned $points points from your recent transaction',
      payload: 'points_earned',
    );
  }

  Future<void> showCashbackReceived(double amount) async {
    await showNotification(
      id: 1003,
      title: 'Cashback Received!',
      body: 'You received \$${amount.toStringAsFixed(2)} cashback',
      payload: 'cashback_received',
    );
  }

  Future<void> showRewardRedeemed(String rewardName) async {
    await showNotification(
      id: 1004,
      title: 'Reward Redeemed!',
      body: 'Your $rewardName reward is ready for pickup',
      payload: 'reward_redeemed',
    );
  }

  Future<void> showMissionCompleted(String missionName, int points) async {
    await showNotification(
      id: 1005,
      title: 'Mission Completed!',
      body: 'You completed "$missionName" and earned $points points',
      payload: 'mission_completed',
    );
  }

  Future<void> showReferralBonus(int points) async {
    await showNotification(
      id: 1006,
      title: 'Referral Bonus!',
      body: 'You earned $points points from a successful referral',
      payload: 'referral_bonus',
    );
  }

  Future<void> showSpinWheelAvailable() async {
    await showNotification(
      id: 1007,
      title: 'Spin the Wheel!',
      body: 'Your daily spin is available. Try your luck now!',
      payload: 'spin_wheel',
    );
  }

  Future<void> showOfferExpiring(String offerName, int hoursLeft) async {
    await showNotification(
      id: 1008,
      title: 'Offer Expiring Soon!',
      body: '$offerName expires in $hoursLeft hours. Don\'t miss out!',
      payload: 'offer_expiring',
    );
  }

  Future<void> cancelNotification(int id) async {
    await _notifications.cancel(id);
  }

  Future<void> cancelAllNotifications() async {
    await _notifications.cancelAll();
  }

  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    return await _notifications.pendingNotificationRequests();
  }

  Importance _mapImportance(NotificationImportance importance) {
    switch (importance) {
      case NotificationImportance.low:
        return Importance.low;
      case NotificationImportance.normal:
        return Importance.defaultImportance;
      case NotificationImportance.high:
        return Importance.high;
      case NotificationImportance.max:
        return Importance.max;
    }
  }
}

enum NotificationImportance {
  low,
  normal,
  high,
  max,
}