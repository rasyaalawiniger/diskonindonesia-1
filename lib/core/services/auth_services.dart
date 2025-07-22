import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';
import '../utils/constants.dart';

final authServiceProvider = StateNotifierProvider<AuthService, AuthState>((ref) {
  return AuthService();
});

class AuthState {
  final bool isLoading;
  final bool isLoggedIn;
  final UserModel? user;
  final String? error;

  const AuthState({
    this.isLoading = false,
    this.isLoggedIn = false,
    this.user,
    this.error,
  });

  AuthState copyWith({
    bool? isLoading,
    bool? isLoggedIn,
    UserModel? user,
    String? error,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      user: user ?? this.user,
      error: error ?? this.error,
    );
  }
}

class AuthService extends StateNotifier<AuthState> {
  final SupabaseClient _supabase = Supabase.instance.client;
  
  AuthService() : super(const AuthState()) {
    _initializeAuth();
  }

  bool get isLoggedIn => state.isLoggedIn;
  UserModel? get currentUser => state.user;

  Future<void> _initializeAuth() async {
    state = state.copyWith(isLoading: true);
    
    try {
      final session = _supabase.auth.currentSession;
      if (session != null) {
        final userData = await _getUserData(session.user.id);
        if (userData != null) {
          state = state.copyWith(
            isLoggedIn: true,
            user: userData,
            isLoading: false,
          );
        } else {
          await signOut();
        }
      } else {
        state = state.copyWith(isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<bool> signIn(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      
      if (response.user != null) {
        final userData = await _getUserData(response.user!.id);
        if (userData != null) {
          await _saveUserSession(userData);
          state = state.copyWith(
            isLoggedIn: true,
            user: userData,
            isLoading: false,
          );
          return true;
        }
      }
      
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to retrieve user data',
      );
      return false;
    } on AuthException catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.message,
      );
      return false;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'An unexpected error occurred',
      );
      return false;
    }
  }

  Future<bool> signUp({
    required String email,
    required String password,
    required String name,
    String? phone,
    String? referralCode,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: {
          'name': name,
          'phone': phone,
          'referral_code': referralCode,
        },
      );
      
      if (response.user != null) {
        // Create user profile in database
        await _createUserProfile(
          userId: response.user!.id,
          email: email,
          name: name,
          phone: phone,
          referralCode: referralCode,
        );
        
        // Process referral bonus if referral code provided
        if (referralCode != null && referralCode.isNotEmpty) {
          await _processReferralBonus(response.user!.id, referralCode);
        }
        
        final userData = await _getUserData(response.user!.id);
        if (userData != null) {
          await _saveUserSession(userData);
          state = state.copyWith(
            isLoggedIn: true,
            user: userData,
            isLoading: false,
          );
          return true;
        }
      }
      
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to create user account',
      );
      return false;
    } on AuthException catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.message,
      );
      return false;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'An unexpected error occurred',
      );
      return false;
    }
  }

  Future<bool> resetPassword(String email) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      await _supabase.auth.resetPasswordForEmail(email);
      state = state.copyWith(isLoading: false);
      return true;
    } on AuthException catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.message,
      );
      return false;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'An unexpected error occurred',
      );
      return false;
    }
  }

  Future<void> signOut() async {
    state = state.copyWith(isLoading: true);
    
    try {
      await _supabase.auth.signOut();
      await _clearUserSession();
      state = const AuthState();
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<UserModel?> _getUserData(String userId) async {
    try {
      final response = await _supabase
          .from('users')
          .select()
          .eq('user_id', userId)
          .single();
      
      return UserModel.fromJson(response);
    } catch (e) {
      return null;
    }
  }

  Future<void> _createUserProfile({
    required String userId,
    required String email,
    required String name,
    String? phone,
    String? referralCode,
  }) async {
    final userReferralCode = _generateReferralCode();
    
    await _supabase.from('users').insert({
      'user_id': userId,
      'email': email,
      'name': name,
      'phone': phone,
      'referral_code': userReferralCode,
      'points_balance': referralCode != null ? 100 : 0, // Welcome bonus if referred
      'wallet_balance': 0.0,
      'role': UserRole.user.name,
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
    });
  }

  Future<void> _processReferralBonus(String newUserId, String referralCode) async {
    try {
      // Find referrer by referral code
      final referrerResponse = await _supabase
          .from('users')
          .select('user_id, points_balance')
          .eq('referral_code', referralCode)
          .single();
      
      if (referrerResponse != null) {
        final referrerId = referrerResponse['user_id'];
        final referrerPoints = referrerResponse['points_balance'] as int;
        
        // Add bonus points to referrer
        await _supabase
            .from('users')
            .update({
              'points_balance': referrerPoints + 100,
              'updated_at': DateTime.now().toIso8601String(),
            })
            .eq('user_id', referrerId);
        
        // Record referral
        await _supabase.from('referrals').insert({
          'referrer_id': referrerId,
          'referee_id': newUserId,
          'bonus_points': 100,
          'created_at': DateTime.now().toIso8601String(),
        });
      }
    } catch (e) {
      // Silently fail referral bonus processing
      print('Referral bonus processing failed: $e');
    }
  }

  String _generateReferralCode() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = DateTime.now().millisecondsSinceEpoch;
    return List.generate(8, (index) => chars[random % chars.length]).join();
  }

  Future<void> _saveUserSession(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_data', user.toJson().toString());
  }

  Future<void> _clearUserSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_data');
  }

  Future<bool> updateUserProfile({
    String? name,
    String? phone,
  }) async {
    if (state.user == null) return false;
    
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final updates = <String, dynamic>{
        'updated_at': DateTime.now().toIso8601String(),
      };
      
      if (name != null) updates['name'] = name;
      if (phone != null) updates['phone'] = phone;
      
      await _supabase
          .from('users')
          .update(updates)
          .eq('user_id', state.user!.userId);
      
      final updatedUser = state.user!.copyWith(
        name: name ?? state.user!.name,
        phone: phone ?? state.user!.phone,
      );
      
      await _saveUserSession(updatedUser);
      state = state.copyWith(
        user: updatedUser,
        isLoading: false,
      );
      
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      return false;
    }
  }

  Future<void> refreshUserData() async {
    if (state.user == null) return;
    
    final userData = await _getUserData(state.user!.userId);
    if (userData != null) {
      await _saveUserSession(userData);
      state = state.copyWith(user: userData);
    }
  }
}