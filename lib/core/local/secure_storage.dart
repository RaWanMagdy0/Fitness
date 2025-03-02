import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageFactory {
  static FlutterSecureStorage? _secureStorageInstance;
  SecureStorageFactory._();

  static Future<FlutterSecureStorage> getInstance() async {
    return _secureStorageInstance ?? const FlutterSecureStorage();
  }

  static Future<void> writeData(
      {required String key, required String value}) async {
    final storage = await getInstance();
    await storage.write(key: key, value: value);
  }

  static Future<String?> readData({required String key}) async {
    final storage = await getInstance();
    return await storage.read(key: key);
  }

  static Future<void> deleteData({required String key}) async {
    final storage = await getInstance();
    await storage.delete(key: key);
  }
}
