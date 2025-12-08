// V2Board API Client
// API client for communicating with V2Board backend

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/models/v2board_models.dart';

/// V2Board API configuration
class V2BoardConfig {
  static const String baseUrl = 'https://www.taisafe.cc';
  static const String apiPrefix = '/api/v1';
  
  static String get apiBaseUrl => '$baseUrl$apiPrefix';
}

/// API error class
class V2BoardApiError implements Exception {
  final String message;
  final int? statusCode;
  
  V2BoardApiError(this.message, [this.statusCode]);
  
  @override
  String toString() => message;
}

/// V2Board API Client
class V2BoardApi {
  late final Dio _dio;
  String? _authToken;
  
  V2BoardApi() {
    _dio = Dio(BaseOptions(
      baseUrl: V2BoardConfig.apiBaseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));
    
    // Add interceptor for auth token
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        if (_authToken != null) {
          options.headers['Authorization'] = _authToken;
        }
        return handler.next(options);
      },
      onError: (error, handler) {
        // Handle 401 unauthorized
        if (error.response?.statusCode == 401) {
          _authToken = null;
        }
        return handler.next(error);
      },
    ));
    
    // Debug logging interceptor
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      logPrint: (obj) => print('[V2Board API] $obj'),
    ));
  }
  
  /// Set auth token
  void setAuthToken(String? token) {
    _authToken = token;
  }
  
  /// Get auth token
  String? get authToken => _authToken;
  
  /// Check if logged in
  bool get isLoggedIn => _authToken != null && _authToken!.isNotEmpty;
  
  /// Parse API response
  T _parseResponse<T>(Response response, T Function(Map<String, dynamic>) parser) {
    final data = response.data;
    if (data is Map<String, dynamic>) {
      // Check for error status
      if (data['status'] != null && data['status'] != 200) {
        throw V2BoardApiError(
          data['message'] ?? 'Unknown error',
          data['status'],
        );
      }
      // Parse data field if exists
      if (data['data'] != null && data['data'] is Map<String, dynamic>) {
        return parser(data['data']);
      }
      return parser(data);
    }
    throw V2BoardApiError('Invalid response format');
  }
  
  /// Parse list response
  List<T> _parseListResponse<T>(Response response, T Function(Map<String, dynamic>) parser) {
    final data = response.data;
    if (data is Map<String, dynamic>) {
      if (data['status'] != null && data['status'] != 200) {
        throw V2BoardApiError(
          data['message'] ?? 'Unknown error',
          data['status'],
        );
      }
      final listData = data['data'];
      if (listData is List) {
        return listData.map((e) => parser(e as Map<String, dynamic>)).toList();
      }
    }
    throw V2BoardApiError('Invalid response format');
  }
  
  // ============ Authentication ============
  
  /// Login with email and password
  Future<V2BoardAuthResponse> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '/passport/auth/login',
        data: {'email': email, 'password': password},
      );
      
      final authResponse = _parseResponse(response, V2BoardAuthResponse.fromJson);
      
      // Debug: Print parsed values
      print('[V2Board Login] authData: ${authResponse.authData}');
      print('[V2Board Login] token: ${authResponse.token}');
      
      // Set token from response
      if (authResponse.authData != null) {
        _authToken = authResponse.authData;
        print('[V2Board Login] Using authData as token');
      } else if (authResponse.token != null) {
        _authToken = authResponse.token;
        print('[V2Board Login] Using token as token');
      }
      
      print('[V2Board Login] Final _authToken: $_authToken');
      
      return authResponse;
    } on DioException catch (e) {
      throw V2BoardApiError(
        e.response?.data?['message'] ?? '登录失败，请检查网络连接',
        e.response?.statusCode,
      );
    }
  }
  
  /// Register new account
  Future<V2BoardAuthResponse> register({
    required String email,
    required String password,
    String? inviteCode,
    String? emailCode,
  }) async {
    try {
      final response = await _dio.post(
        '/passport/auth/register',
        data: {
          'email': email,
          'password': password,
          'password_confirmation': password,
          if (inviteCode != null) 'invite_code': inviteCode,
          if (emailCode != null) 'email_code': emailCode,
        },
      );
      
      final authResponse = _parseResponse(response, V2BoardAuthResponse.fromJson);
      
      if (authResponse.authData != null) {
        _authToken = authResponse.authData;
      } else if (authResponse.token != null) {
        _authToken = authResponse.token;
      }
      
      return authResponse;
    } on DioException catch (e) {
      throw V2BoardApiError(
        e.response?.data?['message'] ?? '注册失败',
        e.response?.statusCode,
      );
    }
  }
  
  /// Request password reset
  Future<void> forgotPassword(String email) async {
    try {
      await _dio.post(
        '/passport/auth/forget',
        data: {'email': email},
      );
    } on DioException catch (e) {
      throw V2BoardApiError(
        e.response?.data?['message'] ?? '重置密码请求失败',
        e.response?.statusCode,
      );
    }
  }
  
  /// Check login status
  Future<bool> checkAuth() async {
    if (_authToken == null) return false;
    try {
      final response = await _dio.get('/passport/auth/check');
      return response.statusCode == HttpStatus.ok;
    } catch (_) {
      return false;
    }
  }
  
  /// Logout
  Future<void> logout() async {
    try {
      await _dio.get('/user/logout');
    } catch (_) {
      // Ignore logout errors
    } finally {
      _authToken = null;
    }
  }
  
  // ============ User ============
  
  /// Get current user info
  Future<V2BoardUser> getUserInfo() async {
    try {
      final response = await _dio.get('/user/info');
      return _parseResponse(response, V2BoardUser.fromJson);
    } on DioException catch (e) {
      throw V2BoardApiError(
        e.response?.data?['message'] ?? '获取用户信息失败',
        e.response?.statusCode,
      );
    }
  }
  
  /// Get subscription info
  Future<V2BoardSubscription> getSubscription() async {
    try {
      final response = await _dio.get('/user/getSubscribe');
      return _parseResponse(response, V2BoardSubscription.fromJson);
    } on DioException catch (e) {
      throw V2BoardApiError(
        e.response?.data?['message'] ?? '获取订阅信息失败',
        e.response?.statusCode,
      );
    }
  }
  
  /// Reset subscription security (get new link)
  Future<void> resetSubscription() async {
    try {
      await _dio.get('/user/resetSecurity');
    } on DioException catch (e) {
      throw V2BoardApiError(
        e.response?.data?['message'] ?? '重置订阅链接失败',
        e.response?.statusCode,
      );
    }
  }
  
  // ============ Notices ============
  
  /// Get notices/announcements
  Future<List<V2BoardNotice>> getNotices() async {
    try {
      final response = await _dio.get('/user/notice/fetch');
      return _parseListResponse(response, V2BoardNotice.fromJson);
    } on DioException catch (e) {
      throw V2BoardApiError(
        e.response?.data?['message'] ?? '获取公告失败',
        e.response?.statusCode,
      );
    }
  }
  
  // ============ Tickets ============
  
  /// Get user tickets
  Future<List<V2BoardTicket>> getTickets() async {
    try {
      final response = await _dio.get('/user/ticket/fetch');
      return _parseListResponse(response, V2BoardTicket.fromJson);
    } on DioException catch (e) {
      throw V2BoardApiError(
        e.response?.data?['message'] ?? '获取工单失败',
        e.response?.statusCode,
      );
    }
  }
  
  /// Create new ticket
  Future<void> createTicket({
    required String subject,
    required String message,
    int level = 2,
  }) async {
    try {
      await _dio.post(
        '/user/ticket/save',
        data: {
          'subject': subject,
          'message': message,
          'level': level,
        },
      );
    } on DioException catch (e) {
      throw V2BoardApiError(
        e.response?.data?['message'] ?? '创建工单失败',
        e.response?.statusCode,
      );
    }
  }
  
  /// Reply to ticket
  Future<void> replyTicket({
    required int ticketId,
    required String message,
  }) async {
    try {
      await _dio.post(
        '/user/ticket/reply',
        data: {
          'id': ticketId,
          'message': message,
        },
      );
    } on DioException catch (e) {
      throw V2BoardApiError(
        e.response?.data?['message'] ?? '回复工单失败',
        e.response?.statusCode,
      );
    }
  }
  
  /// Close ticket
  Future<void> closeTicket(int ticketId) async {
    try {
      await _dio.post(
        '/user/ticket/close',
        data: {'id': ticketId},
      );
    } on DioException catch (e) {
      throw V2BoardApiError(
        e.response?.data?['message'] ?? '关闭工单失败',
        e.response?.statusCode,
      );
    }
  }
  
  // ============ Shop ============
  
  /// Redeem gift card
  Future<Map<String, dynamic>> redeemGiftCard(String giftcard) async {
    try {
      final response = await _dio.post(
        '/user/redeemgiftcard',
        data: {'giftcard': giftcard},
      );
      final data = response.data;
      if (data is Map<String, dynamic>) {
        if (data['status'] != null && data['status'] != 200) {
          throw V2BoardApiError(
            data['message'] ?? '兌換失敗',
            data['status'],
          );
        }
        return data;
      }
      return {'message': '兌換成功'};
    } on DioException catch (e) {
      throw V2BoardApiError(
        e.response?.data?['message'] ?? '禮物卡兌換失敗',
        e.response?.statusCode,
      );
    }
  }
  
  /// Get available plans
  Future<List<V2BoardPlan>> getPlans() async {
    try {
      final response = await _dio.get('/user/plan/fetch');
      final data = response.data;
      if (data is Map<String, dynamic>) {
        if (data['status'] != null && data['status'] != 200) {
          throw V2BoardApiError(
            data['message'] ?? 'Unknown error',
            data['status'],
          );
        }
        final listData = data['data'];
        if (listData is List) {
          return listData.map((e) => V2BoardPlan.fromJson(e as Map<String, dynamic>)).toList();
        }
      }
      return [];
    } on DioException catch (e) {
      throw V2BoardApiError(
        e.response?.data?['message'] ?? '獲取套餐失敗',
        e.response?.statusCode,
      );
    }
  }
  
  /// Verify coupon code
  Future<Map<String, dynamic>> verifyCoupon({
    required String code,
    required int planId,
  }) async {
    try {
      final response = await _dio.post(
        '/user/coupon/check',
        data: {
          'code': code,
          'plan_id': planId,
        },
      );
      final data = response.data;
      if (data is Map<String, dynamic>) {
         // Some versions might just return true/false or object, handle flexibly if needed
         // Based on provided logic, it returns discount info probably
         if (data['status'] != null && data['status'] != 200) {
           throw V2BoardApiError(
             data['message'] ?? '優惠碼無效',
             data['status'],
           );
         }
         return data['data'] ?? data;
      }
      return {'valid': true};
    } on DioException catch (e) {
      throw V2BoardApiError(
        e.response?.data?['message'] ?? '優惠碼驗證失敗',
        e.response?.statusCode,
      );
    }
  }

  /// Create order for a plan
  Future<V2BoardOrder> createOrder({
    required int planId,
    required String cycle,
    String? couponCode,
  }) async {
    try {
      final response = await _dio.post(
        '/user/order/save',
        data: {
          'plan_id': planId,
          'period': cycle,
          if (couponCode != null && couponCode.isNotEmpty) 'coupon_code': couponCode,
        },
      );
      
      // Custom handling: some versions return data as trade_no string directly
      final data = response.data;
      
      // Check for error message in 200 OK response
      if (data is Map<String, dynamic>) {
        if (data['data'] == null && data['message'] != null) {
           throw V2BoardApiError(data['message'], 200);
        }
        if (data['data'] is String) {
          return V2BoardOrder(tradeNo: data['data'] as String);
        }
      }
      
      return _parseResponse(response, V2BoardOrder.fromJson);
    } on DioException catch (e) {
      throw V2BoardApiError(
        e.response?.data?['message'] ?? '創建訂單失敗',
        e.response?.statusCode,
      );
    }
  }
  
  /// Checkout order with balance
  Future<Map<String, dynamic>> checkoutOrder(String tradeNo) async {
    try {
      final response = await _dio.post(
        '/user/order/checkout',
        data: {
          'trade_no': tradeNo,
          'method': 1, // Balance payment
        },
      );
      final data = response.data;
      if (data is Map<String, dynamic>) {
        if (data['status'] != null && data['status'] != 200) {
          throw V2BoardApiError(
            data['message'] ?? '支付失敗',
            data['status'],
          );
        }
        return data;
      }
      return {'message': '支付成功'};
    } on DioException catch (e) {
      throw V2BoardApiError(
        e.response?.data?['message'] ?? '訂單結賬失敗',
        e.response?.statusCode,
      );
    }
  }
  /// Get user orders
  Future<List<V2BoardOrder>> getOrders() async {
    try {
      final response = await _dio.get('/user/order/fetch');
      return _parseListResponse(response, V2BoardOrder.fromJson);
    } on DioException catch (e) {
      throw V2BoardApiError(
        e.response?.data?['message'] ?? '獲取訂單列表失敗',
        e.response?.statusCode,
      );
    }
  }

  /// Cancel order
  Future<void> cancelOrder(String tradeNo) async {
    try {
      await _dio.post(
        '/user/order/cancel',
        data: {'trade_no': tradeNo},
      );
    } on DioException catch (e) {
      throw V2BoardApiError(
        e.response?.data?['message'] ?? '取消訂單失敗',
        e.response?.statusCode,
      );
    }
  }

  /// Get order details
  Future<V2BoardOrder> getOrderDetails(String tradeNo) async {
    try {
      final response = await _dio.get(
        '/user/order/detail',
        queryParameters: {'trade_no': tradeNo},
      );
      return _parseResponse(response, V2BoardOrder.fromJson);
    } on DioException catch (e) {
      throw V2BoardApiError(
        e.response?.data?['message'] ?? '獲取訂單詳情失敗',
        e.response?.statusCode,
      );
    }
  }
}

/// Global V2Board API instance
final v2boardApi = V2BoardApi();
