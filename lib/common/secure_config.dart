import 'dart:convert';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';

/// Secure configuration for sensitive URLs
/// All domain names are encrypted to prevent static analysis extraction
class SecureConfig {
  // =============================================================
  // ENCRYPTION KEY (32 bytes for AES-256)
  // This key is used for XOR-based encryption with SHA-256
  // In production, consider using platform-specific secure storage
  // =============================================================
  static const String _masterKey = 'TaiSafeVPN2024SecureKeyForDomain';
  
  // =============================================================
  // ENCRYPTED DOMAIN CONFIGURATIONS
  // Format: XOR encrypted then Base64 encoded
  // To update: Use _encryptForStorage() method and copy output
  // =============================================================
  
  // Primary API host: cn.bbcareadvi.com.tw (Cloudflare Worker Proxy)
  // This hides the real backend from network inspection
  static const String _encApiHost = 'NV8pbws4zlVeQMClhb6HRQMinuQ=';
  
  // Primary subscription host: cn.bbcareadvi.com.tw (via Worker /s/ path)
  static const String _encSubHost = 'NV8pbws4zlVeQMClhb6HRQMinuQ=';
  
  // Backup domains (in order of priority - includes real backend as fallback)
  static const List<String> _encBackupHosts = [
    'IUZwIx06xlRaR8H9j/M=',       // www.taisafe.cc (original backend)
    'NV8pawgpy1VaRsu9wuST',       // cn.fardragon.tw
    'NV8pYgIywUZMQIqwg/3KXhk=',   // cn.okinawa.com.tw  
  ];
  
  // =============================================================
  // PUBLIC API
  // =============================================================
  
  /// Get decrypted primary API host
  static String get apiHost => _decrypt(_encApiHost);
  
  /// Get full API base URL
  static String get apiBaseUrl => 'https://$apiHost/api/v1';
  
  /// Get decrypted primary subscription host
  static String get subHost => _decrypt(_encSubHost);
  
  /// Get full subscription base URL
  static String get subBaseUrl => 'https://$subHost';
  
  /// Get list of backup hosts (decrypted)
  static List<String> get backupHosts => 
    _encBackupHosts.map(_decrypt).toList();
  
  /// Get all available API URLs (primary + backups) for fallback
  static List<String> get allApiUrls {
    final urls = <String>['https://$apiHost'];
    urls.addAll(backupHosts.map((h) => 'https://$h'));
    return urls;
  }
  
  /// Get all available subscription URLs for fallback
  static List<String> get allSubUrls {
    final urls = <String>['https://$subHost'];
    urls.addAll(backupHosts.map((h) => 'https://$h'));
    return urls;
  }
  
  // =============================================================
  // ENCRYPTION/DECRYPTION UTILITIES
  // =============================================================
  
  /// Derive a key from master key using SHA-256
  static Uint8List _deriveKey() {
    final bytes = utf8.encode(_masterKey);
    final digest = sha256.convert(bytes);
    return Uint8List.fromList(digest.bytes);
  }
  
  /// XOR-based encryption/decryption (symmetric)
  static String _xorCrypt(String input, Uint8List key) {
    final inputBytes = utf8.encode(input);
    final output = Uint8List(inputBytes.length);
    for (var i = 0; i < inputBytes.length; i++) {
      output[i] = inputBytes[i] ^ key[i % key.length];
    }
    return utf8.decode(output);
  }
  
  /// Decrypt a Base64-encoded encrypted string
  static String _decrypt(String encryptedBase64) {
    try {
      final key = _deriveKey();
      final encryptedBytes = base64Decode(encryptedBase64);
      final decrypted = Uint8List(encryptedBytes.length);
      for (var i = 0; i < encryptedBytes.length; i++) {
        decrypted[i] = encryptedBytes[i] ^ key[i % key.length];
      }
      return utf8.decode(decrypted);
    } catch (e) {
      // Fallback to empty string on error (should not happen)
      return '';
    }
  }
  
  /// Encrypt a plain string to Base64 (for generating encrypted constants)
  /// Usage: print(SecureConfig.encryptForStorage('www.taisafe.cc'));
  static String encryptForStorage(String plainText) {
    final key = _deriveKey();
    final plainBytes = utf8.encode(plainText);
    final encrypted = Uint8List(plainBytes.length);
    for (var i = 0; i < plainBytes.length; i++) {
      encrypted[i] = plainBytes[i] ^ key[i % key.length];
    }
    return base64Encode(encrypted);
  }
  
  /// Verify that decryption is working correctly
  static bool verify() {
    try {
      final api = apiHost;
      final sub = subHost;
      final backups = backupHosts;
      return api.isNotEmpty && sub.isNotEmpty && backups.every((h) => h.isNotEmpty);
    } catch (e) {
      return false;
    }
  }
}

/// Dynamic domain manager for fallback support
class DomainManager {
  static int _currentApiIndex = 0;
  static int _currentSubIndex = 0;
  
  /// Get current API base URL
  static String get currentApiUrl {
    final urls = SecureConfig.allApiUrls;
    if (_currentApiIndex >= urls.length) _currentApiIndex = 0;
    return urls[_currentApiIndex];
  }
  
  /// Get current subscription base URL
  static String get currentSubUrl {
    final urls = SecureConfig.allSubUrls;
    if (_currentSubIndex >= urls.length) _currentSubIndex = 0;
    return urls[_currentSubIndex];
  }
  
  /// Mark current API as failed and switch to next backup
  static void switchToNextApi() {
    final urls = SecureConfig.allApiUrls;
    _currentApiIndex = (_currentApiIndex + 1) % urls.length;
  }
  
  /// Mark current subscription as failed and switch to next backup
  static void switchToNextSub() {
    final urls = SecureConfig.allSubUrls;
    _currentSubIndex = (_currentSubIndex + 1) % urls.length;
  }
  
  /// Reset to primary domains
  static void reset() {
    _currentApiIndex = 0;
    _currentSubIndex = 0;
  }
  
  /// Try all domains until one works
  static Future<T?> tryWithFallback<T>({
    required Future<T> Function(String baseUrl) request,
    bool isApi = true,
  }) async {
    final urls = isApi ? SecureConfig.allApiUrls : SecureConfig.allSubUrls;
    
    for (var i = 0; i < urls.length; i++) {
      try {
        final result = await request(urls[i]);
        // Success - update current index
        if (isApi) {
          _currentApiIndex = i;
        } else {
          _currentSubIndex = i;
        }
        return result;
      } catch (e) {
        // Try next domain
        continue;
      }
    }
    
    // All domains failed
    return null;
  }
}
