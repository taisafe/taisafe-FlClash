// V2Board State Providers
// Riverpod providers for V2Board state management

import 'package:fl_clash/api/v2board_api.dart';
import 'package:fl_clash/models/v2board_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fl_clash/models/profile.dart';
import 'package:fl_clash/providers/config.dart';
import 'package:fl_clash/state.dart';

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
      
        print('[UserSubscription] Checking subscription URL...');
        print('[UserSubscription] subscribeUrl: ${subscription?.subscribeUrl}');
        if (subscription?.subscribeUrl != null && subscription!.subscribeUrl!.isNotEmpty) {
          final profiles = ref.read(profilesProvider);
          print('[UserSubscription] Found ${profiles.length} profiles');
          for (var p in profiles) {
            print('[UserSubscription] - Profile: ${p.label}, URL: ${p.url}');
          }
          // Check for 'TaiSafe' or legacy 'TaiSafe Auto'
          final index = profiles.indexWhere((p) => p.label == 'TaiSafe' || p.label == 'TaiSafe Auto');
          print('[UserSubscription] Found TaiSafe profile at index: $index');
          
          if (index != -1) {
            final profile = profiles[index];
            // Check if file actually exists on disk
            final fileExists = await profile.check();
            print('[UserSubscription] Profile file exists: $fileExists');
            
            if (profile.url != subscription.subscribeUrl || !fileExists) {
              print('[UserSubscription] URL changed or file missing, downloading...');
              final newProfile = profile.copyWith(url: subscription.subscribeUrl!);
              // Actually download the new config
              try {
                final downloadedProfile = await newProfile.update();
                ref.read(profilesProvider.notifier).setProfile(downloadedProfile);
                ref.read(currentProfileIdProvider.notifier).update(downloadedProfile.id);
                globalState.appController.applyProfile();
                print('[UserSubscription] Profile updated and applied');
              } catch (e) {
                print('[UserSubscription] Failed to download updated profile: $e');
              }
            } else {
              print('[UserSubscription] Profile already up-to-date, applying...');
              // Just make sure it's applied
              ref.read(currentProfileIdProvider.notifier).update(profile.id);
              globalState.appController.applyProfile();
            }
          } else {
             // Profile missing, create it and DOWNLOAD
             print('[UserSubscription] Profile missing, creating and downloading...');
             final profile = Profile.normal(
               label: 'TaiSafe', 
               url: subscription.subscribeUrl!,
             );
             try {
               // Actually download the subscription content
               print('[UserSubscription] Downloading subscription from: ${subscription.subscribeUrl}');
               final downloadedProfile = await profile.update();
               ref.read(profilesProvider.notifier).setProfile(downloadedProfile);
               ref.read(currentProfileIdProvider.notifier).update(downloadedProfile.id);
               // Trigger the core to apply this profile
               globalState.appController.applyProfile();
               print('[UserSubscription] Profile downloaded and applied successfully');
             } catch (e) {
               print('[UserSubscription] Download failed: $e');
               // Still save the profile metadata for later retry
               ref.read(profilesProvider.notifier).setProfile(profile);
               ref.read(currentProfileIdProvider.notifier).update(profile.id);
             }
          }
        }
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
                 label: 'TaiSafe', 
                 url: subscribeUrl,
               );
               try {
                 print('[LoginAction] Downloading profile content...');
                 final updatedProfile = await profile.update();
                 ref.read(profilesProvider.notifier).setProfile(updatedProfile);
                 ref.read(currentProfileIdProvider.notifier).update(updatedProfile.id);
                 // Trigger apply explicitly
                 globalState.appController.applyProfile();
               } catch (e) {
                 print('[LoginAction] Profile download failed: $e');
                 // Fallback to just setting it (will try again later)
                 ref.read(profilesProvider.notifier).setProfile(profile);
                 ref.read(currentProfileIdProvider.notifier).update(profile.id);
               }
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

// ============ Shop State ============

/// Available plans
@Riverpod(keepAlive: true)
class Plans extends _$Plans {
  @override
  AsyncValue<List<V2BoardPlan>> build() {
    return const AsyncValue.data([]);
  }
  
  Future<void> fetch() async {
    if (!ref.read(isLoggedInProvider)) {
      state = const AsyncValue.data([]);
      return;
    }
    
    state = const AsyncValue.loading();
    try {
      final plans = await v2boardApi.getPlans();
      // Filter only visible plans
      final visiblePlans = plans.where((p) => p.show == 1).toList();
      // Sort by sort field
      visiblePlans.sort((a, b) => (a.sort ?? 0).compareTo(b.sort ?? 0));
      state = AsyncValue.data(visiblePlans);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
  
  void clear() {
    state = const AsyncValue.data([]);
  }
}

/// Gift card redemption action
@Riverpod(keepAlive: true)
class RedeemGiftCard extends _$RedeemGiftCard {
  @override
  AsyncValue<String?> build() {
    return const AsyncValue.data(null);
  }
  
  Future<bool> redeem(String code) async {
    state = const AsyncValue.loading();
    try {
      final result = await v2boardApi.redeemGiftCard(code);
      final message = result['message'] ?? '兌換成功';
      state = AsyncValue.data(message as String);
      
      // Refresh user info to update balance
      await ref.read(currentUserProvider.notifier).fetch();
      
      return true;
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      return false;
    }
  }
  
  void reset() {
    state = const AsyncValue.data(null);
  }
}

/// Purchase plan action
@Riverpod(keepAlive: true)
class PurchasePlan extends _$PurchasePlan {
  @override
  AsyncValue<String?> build() {
    return const AsyncValue.data(null);
  }
  
  Future<bool> purchase({
    required int planId,
    required String cycle,
    String? couponCode,
  }) async {
    state = const AsyncValue.loading();
    try {
      // Create order
      final order = await v2boardApi.createOrder(
        planId: planId,
        cycle: cycle,
        couponCode: couponCode,
      );
      
      if (order.tradeNo == null) {
        state = AsyncValue.error('創建訂單失敗', StackTrace.current);
        return false;
      }
      
      // Checkout with balance
      final result = await v2boardApi.checkoutOrder(order.tradeNo!);
      final message = result['message'] ?? '購買成功';
      state = AsyncValue.data(message as String);
      
      // Refresh user info and subscription
      await ref.read(currentUserProvider.notifier).fetch();
      await ref.read(userSubscriptionProvider.notifier).fetch();
      
      return true;
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      return false;
    }
  }
  
  void reset() {
    state = const AsyncValue.data(null);
  }
}

/// User orders
@Riverpod(keepAlive: true)
class Orders extends _$Orders {
  @override
  AsyncValue<List<V2BoardOrder>> build() {
    return const AsyncValue.data([]);
  }
  
  Future<void> fetch() async {
    if (!ref.read(isLoggedInProvider)) {
      state = const AsyncValue.data([]);
      return;
    }
    
    state = const AsyncValue.loading();
    try {
      final orders = await v2boardApi.getOrders();
      // Sort by creation time desc
      orders.sort((a, b) => (b.createdAt ?? 0).compareTo(a.createdAt ?? 0));
      state = AsyncValue.data(orders);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
  
  void clear() {
    state = const AsyncValue.data([]);
  }
}

/// Order actions (cancel, checkout)
@Riverpod(keepAlive: true)
class OrderAction extends _$OrderAction {
  @override
  AsyncValue<String?> build() {
    return const AsyncValue.data(null);
  }
  
  Future<bool> cancel(String tradeNo) async {
    state = const AsyncValue.loading();
    try {
      await v2boardApi.cancelOrder(tradeNo);
      state = const AsyncValue.data('訂單已取消');
      await ref.read(ordersProvider.notifier).fetch();
      return true;
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      return false;
    }
  }
  
  Future<bool> checkout(String tradeNo) async {
    state = const AsyncValue.loading();
    try {
      final result = await v2boardApi.checkoutOrder(tradeNo);
      final message = result['message'] ?? '支付成功';
      state = AsyncValue.data(message as String);
      
      // Refresh user info and orders
      await ref.read(currentUserProvider.notifier).fetch();
      await ref.read(ordersProvider.notifier).fetch();
      await ref.read(userSubscriptionProvider.notifier).fetch();
      
      return true;
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      return false;
    }
  }
  
  void reset() {
    state = const AsyncValue.data(null);
  }
}
