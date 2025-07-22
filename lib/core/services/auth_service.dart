import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

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
      final prefs = await SharedPreferences.getInstance();
      final userData = prefs.getString('user_data');
      
      if (userData != null) {
        final userMap = jsonDecode(userData);
        final user = UserModel.fromJson(userMap);
        state = state.copyWith(
          isLoggedIn: true,
          user: user,
          isLoading: false,
        );
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
      // Hash password
      final hashedPassword = _hashPassword(password);
      
      // Check user credentials
      final response = await _supabase
          .from('users')
          .select()
          .eq('email', email)
          .eq('password_hash', hashedPassword)
          .single();
      
      if (response != null) {
        final userData = UserModel.fromJson(response);
        await _saveUserSession(userData);
        state = state.copyWith(
          isLoggedIn: true,
          user: userData,
          isLoading: false,
        );
        return true;
      }
      
      state = state.copyWith(
        isLoading: false,
        error: 'Invalid email or password',
      );
      return false;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Login failed: ${e.toString()}',
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
      // Check if email already exists
      final existingUser = await _supabase
          .from('users')
          .select('user_id')
          .eq('email', email)
          .maybeSingle();
      
      if (existingUser != null) {
        state = state.copyWith(
          isLoading: false,
          error: 'Email already exists',
        );
        return false;
      }
      
      // Hash password
      final hashedPassword = _hashPassword(password);
      final userReferralCode = _generateReferralCode();
      
      // Create user
      final response = await _supabase.from('users').insert({
        'email': email,
        'password_hash': hashedPassword,
        'nama': name,
        'telepon': phone,
        'kode_referral': userReferralCode,
        'saldo_poin': referralCode != null ? 100 : 0,
        'saldo_dompet': 0.0,
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      }).select().single();
      
      // Process referral bonus if referral code provided
      if (referralCode != null && referralCode.isNotEmpty) {
        await _processReferralBonus(response['user_id'], referralCode);
      }
      
      final userData = UserModel.fromJson(response);
      await _saveUserSession(userData);
      state = state.copyWith(
        isLoggedIn: true,
        user: userData,
        isLoading: false,
      );
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Registration failed: ${e.toString()}',
      );
      return false;
    }
  }

  Future<bool> resetPassword(String email) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      // Check if user exists
      final user = await _supabase
          .from('users')
          .select('user_id')
          .eq('email', email)
          .maybeSingle();
      
      if (user == null) {
        state = state.copyWith(
          isLoading: false,
          error: 'Email not found',
        );
        return false;
      }
      
      // In a real app, you would send a reset email here
      // For now, we'll just return success
      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Password reset failed: ${e.toString()}',
      );
      return false;
    }
  }

  Future<void> signOut() async {
    state = state.copyWith(isLoading: true);
    
    try {
      await _clearUserSession();
      state = const AuthState();
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> _processReferralBonus(String newUserId, String referralCode) async {
    try {
      // Find referrer by referral code
      final referrerResponse = await _supabase
          .from('users')
          .select('user_id, saldo_poin')
          .eq('kode_referral', referralCode)
          .maybeSingle();
      
      if (referrerResponse != null) {
        final referrerId = referrerResponse['user_id'];
        final referrerPoints = referrerResponse['saldo_poin'] as int;
        
        // Add bonus points to referrer
        await _supabase
            .from('users')
            .update({
              'saldo_poin': referrerPoints + 100,
              'updated_at': DateTime.now().toIso8601String(),
            })
            .eq('user_id', referrerId);
        
        // Record referral
        await _supabase.from('referral').insert({
          'referrer_id': referrerId,
          'referee_id': newUserId,
          'poin_bonus': 100,
          'created_at': DateTime.now().toIso8601String(),
        });
      }
    } catch (e) {
      // Silently fail referral bonus processing
      print('Referral bonus processing failed: $e');
    }
  }

  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  String _generateReferralCode() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = DateTime.now().millisecondsSinceEpoch;
    return List.generate(8, (index) => chars[random % chars.length]).join();
  }

  Future<void> _saveUserSession(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_data', jsonEncode(user.toJson()));
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
      
      if (name != null) updates['nama'] = name;
      if (phone != null) updates['telepon'] = phone;
      
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
    
    try {
      final response = await _supabase
          .from('users')
          .select()
          .eq('user_id', state.user!.userId)
          .single();
      
      final userData = UserModel.fromJson(response);
      await _saveUserSession(userData);
      state = state.copyWith(user: userData);
    } catch (e) {
      print('Failed to refresh user data: $e');
    }
  }
}