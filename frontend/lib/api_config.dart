import 'dart:io';

class ApiConfig {
  static final String _baseUrl = _getBaseUrl();

  static String _getBaseUrl() {
    if (Platform.isAndroid) {
      return "http://10.0.2.2:3000";
    } else if (Platform.isIOS) {
      return "http://localhost:3000";
    } else {
      return "http://192.168.1.100:3000";
    }
  }

  static String get baseUrl => _baseUrl;
}
