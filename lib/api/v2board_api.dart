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
}

/// Global V2Board API instance
final v2boardApi = V2BoardApi();
