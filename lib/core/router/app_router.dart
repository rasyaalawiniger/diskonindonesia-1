import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/auth/presentation/screens/forgot_password_screen.dart';
import '../../features/onboarding/presentation/screens/splash_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/home/presentation/screens/main_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/rewards/presentation/screens/rewards_screen.dart';
import '../../features/rewards/presentation/screens/reward_detail_screen.dart';
import '../../features/coupons/presentation/screens/coupons_screen.dart';
import '../../features/coupons/presentation/screens/coupon_detail_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/profile/presentation/screens/settings_screen.dart';
import '../../features/transactions/presentation/screens/transaction_history_screen.dart';
import '../../features/gamification/presentation/screens/daily_checkin_screen.dart';
import '../../features/gamification/presentation/screens/spin_wheel_screen.dart';
import '../../features/gamification/presentation/screens/missions_screen.dart';
import '../../features/gamification/presentation/screens/referral_screen.dart';
import '../../features/merchant/presentation/screens/merchant_dashboard_screen.dart';
import '../../features/merchant/presentation/screens/merchant_offers_screen.dart';
import '../../features/merchant/presentation/screens/merchant_analytics_screen.dart';
import '../../features/admin/presentation/screens/admin_dashboard_screen.dart';
import '../../features/admin/presentation/screens/admin_users_screen.dart';
import '../../features/admin/presentation/screens/admin_merchants_screen.dart';
import '../../features/qr/presentation/screens/qr_scanner_screen.dart';
import '../services/auth_services.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final authService = ref.watch(authServiceProvider);
  
  return GoRouter(
    initialLocation: '/splash',
    redirect: (context, state) {
      final isLoggedIn = authService.isLoggedIn;
      final isLoggingIn = state.matchedLocation == '/login' || 
                         state.matchedLocation == '/register' ||
                         state.matchedLocation == '/forgot-password';
      
      // If not logged in and not on auth screens, redirect to login
      if (!isLoggedIn && !isLoggingIn && 
          state.matchedLocation != '/splash' && 
          state.matchedLocation != '/onboarding') {
        return '/login';
      }
      
      // If logged in and on auth screens, redirect to home
      if (isLoggedIn && isLoggingIn) {
        return '/main';
      }
      
      return null;
    },
    routes: [
      // Splash & Onboarding
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      
      // Authentication
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/forgot-password',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      
      // Main App with Bottom Navigation
      ShellRoute(
        builder: (context, state, child) => MainScreen(child: child),
        routes: [
          GoRoute(
            path: '/main',
            redirect: (context, state) => '/home',
          ),
          GoRoute(
            path: '/home',
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: '/rewards',
            builder: (context, state) => const RewardsScreen(),
          ),
          GoRoute(
            path: '/coupons',
            builder: (context, state) => const CouponsScreen(),
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
      
      // Detailed Screens
      GoRoute(
        path: '/reward-detail/:id',
        builder: (context, state) => RewardDetailScreen(
          rewardId: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        path: '/coupon-detail/:id',
        builder: (context, state) => CouponDetailScreen(
          couponId: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        path: '/transaction-history',
        builder: (context, state) => const TransactionHistoryScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      
      // Gamification
      GoRoute(
        path: '/daily-checkin',
        builder: (context, state) => const DailyCheckinScreen(),
      ),
      GoRoute(
        path: '/spin-wheel',
        builder: (context, state) => const SpinWheelScreen(),
      ),
      GoRoute(
        path: '/missions',
        builder: (context, state) => const MissionsScreen(),
      ),
      GoRoute(
        path: '/referral',
        builder: (context, state) => const ReferralScreen(),
      ),
      
      // QR Scanner
      GoRoute(
        path: '/qr-scanner',
        builder: (context, state) => const QRScannerScreen(),
      ),
      
      // Merchant Dashboard
      GoRoute(
        path: '/merchant-dashboard',
        builder: (context, state) => const MerchantDashboardScreen(),
      ),
      GoRoute(
        path: '/merchant-offers',
        builder: (context, state) => const MerchantOffersScreen(),
      ),
      GoRoute(
        path: '/merchant-analytics',
        builder: (context, state) => const MerchantAnalyticsScreen(),
      ),
      
      // Admin Dashboard
      GoRoute(
        path: '/admin-dashboard',
        builder: (context, state) => const AdminDashboardScreen(),
      ),
      GoRoute(
        path: '/admin-users',
        builder: (context, state) => const AdminUsersScreen(),
      ),
      GoRoute(
        path: '/admin-merchants',
        builder: (context, state) => const AdminMerchantsScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              'Page Not Found',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'The page you are looking for does not exist.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go('/home'),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
});