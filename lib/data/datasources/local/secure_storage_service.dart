import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum SecureStorageKey {
  token,

  
}
class SecureStorageService {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  SecureStorageService();

  Future<void> write(SecureStorageKey key, String value) async {
    await _secureStorage.write(key: key.name, value: value);
  }

  Future<String?> read(SecureStorageKey key) async {
    return await _secureStorage.read(key: key.name);
  }

  Future<void> delete(SecureStorageKey key) async {
    await _secureStorage.delete(key: key.name);
  }
}