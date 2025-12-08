// V2Board State Providers
// Riverpod providers for V2Board state management

import 'package:fl_clash/api/v2board_api.dart';
import 'package:fl_clash/models/v2board_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fl_clash/models/profile.dart';
import 'package:fl_clash/providers/config.dart';

part 'generated/v2board_provider.g.dart';

// ============ Auth State ============

/// Persisted auth token
@Riverpod(keepAlive: true)
class AuthToken extends _$AuthToken {
  static const _tokenKey = 'v2board_auth_token';
  static const _emailKey = 'v2board_email';
  
  @override
  String? build() {
    _loadToken();
    return null;
  }
  
  Future<void> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_tokenKey);
    if (token != null && token.isNotEmpty) {
      state = token;
      v2boardApi.setAuthToken(token);
    }
  }
  
  Future<void> setToken(String? token, {String? email}) async {
    state = token;
    v2boardApi.setAuthToken(token);
    
    final prefs = await SharedPreferences.getInstance();
    if (token != null) {
      await prefs.setString(_tokenKey, token);
      if (email != null) {
        await prefs.setString(_emailKey, email);
      }
    } else {
      await prefs.remove(_tokenKey);
    }
  }
  
  Future<String?> getSavedEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_emailKey);
  }
  
  Future<void> clear() async {
    state = null;
    v2boardApi.setAuthToken(null);
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }
}

/// Is user logged in
@Riverpod(keepAlive: true)
bool isLoggedIn(Ref ref) {
  final token = ref.watch(authTokenProvider);
  return token != null && token.isNotEmpty;
}

// ============ User State ============

/// Current user info
@Riverpod(keepAlive: true)
class CurrentUser extends _$CurrentUser {
  @override
  AsyncValue<V2BoardUser?> build() {
    return const AsyncValue.data(null);
  }
  
  Future<void> fetch() async {
    if (!ref.read(isLoggedInProvider)) {
      state = const AsyncValue.data(null);
      return;
    }
    
    state = const AsyncValue.loading();
    try {
      final user = await v2boardApi.getUserInfo();
      state = AsyncValue.data(user);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
  
  void clear() {
    state = const AsyncValue.data(null);
  }
}

/// User subscription info
@Riverpod(keepAlive: true)
class UserSubscription extends _$UserSubscription {
  @override
  AsyncValue<V2BoardSubscription?> build() {
    return const AsyncValue.data(null);
  }
  
  Future<void> fetch() async {
    if (!ref.read(isLoggedInProvider)) {
      state = const AsyncValue.data(null);
      return;
    }
    
    state = const AsyncValue.loading();
    try {
      final subscription = await v2boardApi.getSubscription();
      state = AsyncValue.data(subscription);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
  
  Future<void> reset() async {
    state = const AsyncValue.loading();
    try {
      await v2boardApi.resetSubscription();
      await fetch();
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
  
  void clear() {
    state = const AsyncValue.data(null);
  }
}

// ============ Notices State ============

/// Notices/Announcements
@Riverpod(keepAlive: true)
class Notices extends _$Notices {
  @override
  AsyncValue<List<V2BoardNotice>> build() {
    return const AsyncValue.data([]);
  }
  
  Future<void> fetch() async {
    if (!ref.read(isLoggedInProvider)) {
      state = const AsyncValue.data([]);
      return;
    }
    
    state = const AsyncValue.loading();
    try {
      final notices = await v2boardApi.getNotices();
      state = AsyncValue.data(notices);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
  
  void clear() {
    state = const AsyncValue.data([]);
  }
}

// ============ Tickets State ============

/// User tickets
@Riverpod(keepAlive: true)
class Tickets extends _$Tickets {
  @override
  AsyncValue<List<V2BoardTicket>> build() {
    return const AsyncValue.data([]);
  }
  
  Future<void> fetch() async {
    if (!ref.read(isLoggedInProvider)) {
      state = const AsyncValue.data([]);
      return;
    }
    
    state = const AsyncValue.loading();
    try {
      final tickets = await v2boardApi.getTickets();
      state = AsyncValue.data(tickets);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
  
  Future<void> createTicket({
    required String subject,
    required String message,
  }) async {
    try {
      await v2boardApi.createTicket(subject: subject, message: message);
      await fetch();
    } catch (e) {
      rethrow;
    }
  }
  
  Future<void> replyTicket({
    required int ticketId,
    required String message,
  }) async {
    try {
      await v2boardApi.replyTicket(ticketId: ticketId, message: message);
      await fetch();
    } catch (e) {
      rethrow;
    }
  }
  
  Future<void> closeTicket(int ticketId) async {
    try {
      await v2boardApi.closeTicket(ticketId);
      await fetch();
    } catch (e) {
      rethrow;
    }
  }
  
  void clear() {
    state = const AsyncValue.data([]);
  }
}

// ============ Auth Actions ============

/// Login action
@Riverpod(keepAlive: true)
class LoginAction extends _$LoginAction {
  @override
  AsyncValue<bool> build() {
    return const AsyncValue.data(false);
  }
  
  Future<bool> login(String email, String password) async {
    print('[LoginAction] Starting login...');
    state = const AsyncValue.loading();
    try {
      final response = await v2boardApi.login(email, password);
      final token = response.authData ?? response.token;
      
      print('[LoginAction] Got token: ${token?.substring(0, 20)}...');
      
      if (token != null) {
        print('[LoginAction] Setting token in provider...');
        await ref.read(authTokenProvider.notifier).setToken(token, email: email);
        
        print('[LoginAction] Token set, fetching user data...');
        // Fetch user data after login
        try {
          await ref.read(currentUserProvider.notifier).fetch();
          print('[LoginAction] User data fetched');
        } catch (e) {
          print('[LoginAction] Error fetching user: $e');
        }
        
        try {
          await ref.read(userSubscriptionProvider.notifier).fetch();
          print('[LoginAction] Subscription fetched');
        } catch (e) {
          print('[LoginAction] Error fetching subscription: $e');
        }
        
        try {
          await ref.read(noticesProvider.notifier).fetch();
          print('[LoginAction] Notices fetched');
        } catch (e) {
          print('[LoginAction] Error fetching notices: $e');
        }
        
        print('[LoginAction] Login successful!');

        try {
          print('[LoginAction] Checking for subscription to auto-import...');
          await ref.read(userSubscriptionProvider.notifier).fetch();
          final sub = ref.read(userSubscriptionProvider).value;
          final subscribeUrl = sub?.subscribeUrl;
          
          if (subscribeUrl != null && subscribeUrl.isNotEmpty) {
             final profiles = ref.read(profilesProvider);
             final existingIndex = profiles.indexWhere((p) => p.url == subscribeUrl);
             
             if (existingIndex != -1) {
               print('[LoginAction] Profile already exists, updating selection');
               ref.read(currentProfileIdProvider.notifier).update(profiles[existingIndex].id);
             } else {
               print('[LoginAction] Creating new profile');
               final profile = Profile.normal(
                 label: 'TaiSafe Auto', 
                 url: subscribeUrl,
               );
               ref.read(profilesProvider.notifier).setProfile(profile);
               ref.read(currentProfileIdProvider.notifier).update(profile.id);
             }
          }
        } catch (e) {
          print('[LoginAction] Auto-import error: $e');
        }

        state = const AsyncValue.data(true);
        return true;
      }
      
      print('[LoginAction] No token received');
      state = AsyncValue.error('登录失败：未获取到认证信息', StackTrace.current);
      return false;
    } catch (e) {
      print('[LoginAction] Error: $e');
      state = AsyncValue.error(e, StackTrace.current);
      return false;
    }
  }
  
  Future<void> logout() async {
    try {
      await v2boardApi.logout();
    } catch (_) {
      // Ignore logout errors
    }
    
    await ref.read(authTokenProvider.notifier).clear();
    ref.read(currentUserProvider.notifier).clear();
    ref.read(userSubscriptionProvider.notifier).clear();
    ref.read(noticesProvider.notifier).clear();
    ref.read(ticketsProvider.notifier).clear();
    
    state = const AsyncValue.data(false);
  }
}

/// Register action
@riverpod
class RegisterAction extends _$RegisterAction {
  @override
  AsyncValue<bool> build() {
    return const AsyncValue.data(false);
  }
  
  Future<bool> register({
    required String email,
    required String password,
    String? inviteCode,
  }) async {
    state = const AsyncValue.loading();
    try {
      final response = await v2boardApi.register(
        email: email,
        password: password,
        inviteCode: inviteCode,
      );
      final token = response.authData ?? response.token;
      
      if (token != null) {
        await ref.read(authTokenProvider.notifier).setToken(token, email: email);
        await ref.read(currentUserProvider.notifier).fetch();
        await ref.read(userSubscriptionProvider.notifier).fetch();
        
        state = const AsyncValue.data(true);
        return true;
      }
      
      state = AsyncValue.error('注册失败', StackTrace.current);
      return false;
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      return false;
    }
  }
}
