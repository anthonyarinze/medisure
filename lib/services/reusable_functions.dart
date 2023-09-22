import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';

class ReusableFunctions {
  static const FlutterSecureStorage _flutterSecureStorage = FlutterSecureStorage();

  static final Logger _logger = Logger(printer: PrettyPrinter(colors: true, printTime: true, printEmojis: true));

  static void logInfo(message) => _logger.i(message);

  static void logDebug(message) => _logger.d(message);

  static void logError(message, {dynamic error, StackTrace? stackTrace}) {
    _logger.e("An error occurred \n $message", error: error, stackTrace: stackTrace);

    if (error is DioException) {
      _logger.e(error.response?.data);
    }
  }

  static Future<bool> getInternet() async {
    try {
      final result = await InternetAddress.lookup("google.com");
      return result.isNotEmpty && result.first.rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }
}
