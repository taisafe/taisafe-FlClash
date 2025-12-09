// Helper script to generate encrypted domain strings
// Run with: dart run tool/generate_encrypted_domains.dart

import 'dart:convert';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';

const masterKey = 'TaiSafeVPN2024SecureKeyForDomain';

Uint8List deriveKey() {
  final bytes = utf8.encode(masterKey);
  final digest = sha256.convert(bytes);
  return Uint8List.fromList(digest.bytes);
}

String encrypt(String plainText) {
  final key = deriveKey();
  final plainBytes = utf8.encode(plainText);
  final encrypted = Uint8List(plainBytes.length);
  for (var i = 0; i < plainBytes.length; i++) {
    encrypted[i] = plainBytes[i] ^ key[i % key.length];
  }
  return base64Encode(encrypted);
}

String decrypt(String encryptedBase64) {
  final key = deriveKey();
  final encryptedBytes = base64Decode(encryptedBase64);
  final decrypted = Uint8List(encryptedBytes.length);
  for (var i = 0; i < encryptedBytes.length; i++) {
    decrypted[i] = encryptedBytes[i] ^ key[i % key.length];
  }
  return utf8.decode(decrypted);
}

void main() {
  print('=== Generating Encrypted Domain Strings ===\n');
  
  final domains = {
    'API Host': 'www.taisafe.cc',
    'Sub Host': 'qq.xcsqq.top',
    'Backup 1': 'cn.fardragon.tw',
    'Backup 2': 'cn.okinawa.com.tw',
    'Backup 3': 'cn.bbcareadvi.com.tw',
  };
  
  for (final entry in domains.entries) {
    final encrypted = encrypt(entry.value);
    final verified = decrypt(encrypted);
    print('${entry.key}: ${entry.value}');
    print('  Encrypted: $encrypted');
    print('  Verified:  $verified');
    print('  Match: ${verified == entry.value}');
    print('');
  }
  
  print('\n=== Copy these values to secure_config.dart ===\n');
  print("static const String _encApiHost = '${encrypt('www.taisafe.cc')}';");
  print("static const String _encSubHost = '${encrypt('qq.xcsqq.top')}';");
  print("static const List<String> _encBackupHosts = [");
  print("  '${encrypt('cn.fardragon.tw')}',      // cn.fardragon.tw");
  print("  '${encrypt('cn.okinawa.com.tw')}',  // cn.okinawa.com.tw");
  print("  '${encrypt('cn.bbcareadvi.com.tw')}',  // cn.bbcareadvi.com.tw");
  print("];");
}
