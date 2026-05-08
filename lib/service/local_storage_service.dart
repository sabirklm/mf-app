import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  SecureStorageService._();

  static final SecureStorageService instance = SecureStorageService._();

  final _storage = const FlutterSecureStorage();

  static const String accessTokenKey = "access_t";
  static const String refreshTokenKey = "refresh_t";
  static const String userIdKey = "user_id";

  Future<void> write({required String key, required String value}) async {
    await _storage.write(key: key, value: value);
  }

  Future<String?> read(String key) async {
    return await _storage.read(key: key);
    // return null;
  }

  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  Future<void> clear() async {
    await _storage.deleteAll();
  }

  Future<bool> contains(String key) async {
    return await _storage.containsKey(key: key);
  }
}
