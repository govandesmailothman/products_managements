import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';

class ApiConstants {
  ApiConstants._();

  /// Can be overridden at build/run time via:
  /// flutter run --dart-define=API_BASE_URL=http://192.168.1.100:8000/api
  static const String _customBaseUrl = String.fromEnvironment('API_BASE_URL');

  /// Dynamically determines the appropriate base URL based on the runtime environment.
  /// - Android Emulator: 10.0.2.2 maps to host machine localhost
  /// - iOS Simulator / Web / Desktop: 127.0.0.1
  /// - Physical device: set via --dart-define=API_BASE_URL=...
  static String get baseUrl {
    if (_customBaseUrl.isNotEmpty) {
      return _customBaseUrl;
    }

    if (kIsWeb) {
      return 'http://127.0.0.1:8000/api';
    }

    try {
      if (Platform.isAndroid) {
        return 'http://10.0.2.2:8000/api';
      }
    } catch (_) {
      // Fallback if platform query is not available
    }

    return 'http://127.0.0.1:8000/api';
  }

  static const String productsEndpoint = '/products';

  static const Duration timeoutDuration = Duration(seconds: 15);
}
