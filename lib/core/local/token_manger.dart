import 'secure_storage.dart';

class TokenManager {
  static const String tokenKey = "token";

  static Future<void> setToken({required String token}) async {
    return await SecureStorageFactory.writeData(key: tokenKey, value: token);
  }

  static Future<String?> getToken() async {
    return await SecureStorageFactory.readData(key: tokenKey);
  }

  static Future<void> deleteToken() async {
    return await SecureStorageFactory.deleteData(key: tokenKey);
  }
}
