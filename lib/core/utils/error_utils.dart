import 'package:dio/dio.dart';

import '../framework/kprint.dart';

class ErrorUtils {
  static String getErrorMessage(dynamic error) {
    if (error is DioException) {
      return _getDioErrorMessage(error);
    }

    // For other exceptions, try to get a meaningful message
    final errorString = error.toString();

    // If it's a generic exception, return a more user-friendly message
    if (errorString.contains('Exception:')) {
      return errorString.split('Exception:').last.trim();
    }

    return errorString;
  }

  static String _getDioErrorMessage(DioException error) {
    // Log the full error for debugging
    kPrint('DioException Type: ${error.type}');
    kPrint('DioException Message: ${error.message}');
    kPrint('DioException Response: ${error.response?.data}');
    kPrint('DioException Status Code: ${error.response?.statusCode}');

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection timeout. Please check your internet connection and try again.';

      case DioExceptionType.badResponse:
        // Try to extract error message from response
        final statusCode = error.response?.statusCode;
        final responseData = error.response?.data;

        if (responseData is Map<String, dynamic>) {
          // TMDb API error format
          if (responseData.containsKey('status_message')) {
            return responseData['status_message'] as String;
          }
          if (responseData.containsKey('errors') &&
              responseData['errors'] is List) {
            final errors = responseData['errors'] as List;
            if (errors.isNotEmpty) {
              return errors.first.toString();
            }
          }
        }

        // Handle specific status codes
        switch (statusCode) {
          case 401:
            return 'Invalid username or password. Please try again.';
          case 403:
            return 'Access denied. Please check your credentials.';
          case 404:
            return 'Service not found. Please try again later.';
          case 500:
          case 502:
          case 503:
            return 'Server error. Please try again later.';
          default:
            return 'An error occurred. Please try again.';
        }

      case DioExceptionType.cancel:
        return 'Request was cancelled. Please try again.';

      case DioExceptionType.connectionError:
        return 'No internet connection. Please check your network and try again.';

      case DioExceptionType.badCertificate:
        return 'Security error. Please try again.';

      case DioExceptionType.unknown:
        final message = error.message;
        if (message != null && message.isNotEmpty) {
          // Check for common network error messages
          if (message.contains('SocketException') ||
              message.contains('Failed host lookup') ||
              message.contains('Network is unreachable')) {
            return 'No internet connection. Please check your network and try again.';
          }
          return message;
        }
        return 'An unexpected error occurred. Please try again.';
    }
  }

  /// Logs error details for debugging
  static void logError(dynamic error, {String? context}) {
    if (context != null) {
      kPrint('Error in $context:');
    }

    if (error is DioException) {
      kPrint('DioException Details:');
      kPrint('  Type: ${error.type}');
      kPrint('  Message: ${error.message}');
      kPrint('  Request Path: ${error.requestOptions.path}');
      kPrint('  Request Method: ${error.requestOptions.method}');
      kPrint('  Status Code: ${error.response?.statusCode}');
      kPrint('  Response Data: ${error.response?.data}');
      kPrint('  Stack Trace: ${error.stackTrace}');
    } else {
      kPrint('Error: $error');
      kPrint('Error Type: ${error.runtimeType}');
    }
  }
}
