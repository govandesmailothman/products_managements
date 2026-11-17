import 'dart:async';
import 'dart:convert';
import 'dart:io' show SocketException, HttpException;

import 'package:http/http.dart' as http;

import '../constants/api_constants.dart';

/// Exception thrown when an API request fails.
class ApiException implements Exception {
  final String message;
  final int? statusCode;

  const ApiException(this.message, [this.statusCode]);

  @override
  String toString() => 'ApiException: $message (status: $statusCode)';
}

/// Specialized exception for network connectivity failures.
class NetworkException extends ApiException {
  const NetworkException([
    String message = 'Unable to connect to the server. Please check your internet connection.',
  ]) : super(message, null);
}

/// Reusable HTTP client for communicating with the backend REST API.
class ApiClient {
  final http.Client _client;
  final String _baseUrl;

  ApiClient({http.Client? client, String? baseUrl})
    : _client = client ?? http.Client(),
      _baseUrl = baseUrl ?? ApiConstants.baseUrl;

  String get baseUrl => _baseUrl;

  Map<String, String> get _headers => {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };

  /// Performs a GET request to the specified endpoint.
  Future<dynamic> get(String endpoint) async {
    final uri = Uri.parse('$_baseUrl$endpoint');
    try {
      final response = await _client
          .get(uri, headers: _headers)
          .timeout(ApiConstants.timeoutDuration);

      return _handleResponse(response);
    } on http.ClientException catch (e) {
      throw NetworkException(
        'Network connection failed. Please ensure the backend server is running (${e.message}).',
      );
    } on SocketException catch (_) {
      throw const NetworkException();
    } on HttpException catch (_) {
      throw const NetworkException('HTTP protocol error occurred.');
    } on TimeoutException catch (_) {
      throw const ApiException('Connection timed out. Please try again later.');
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException('Unexpected error occurred: $e');
    }
  }

  /// Performs a POST request to the specified endpoint with a JSON body.
  Future<dynamic> post(String endpoint, Map<String, dynamic> body) async {
    final uri = Uri.parse('$_baseUrl$endpoint');
    try {
      final response = await _client
          .post(uri, headers: _headers, body: jsonEncode(body))
          .timeout(ApiConstants.timeoutDuration);

      return _handleResponse(response);
    } on http.ClientException catch (e) {
      throw NetworkException(
        'Network connection failed. Please ensure the backend server is running (${e.message}).',
      );
    } on SocketException catch (_) {
      throw const NetworkException();
    } on HttpException catch (_) {
      throw const NetworkException('HTTP protocol error occurred.');
    } on TimeoutException catch (_) {
      throw const ApiException('Connection timed out. Please try again later.');
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException('Unexpected error occurred: $e');
    }
  }

  /// Evaluates the HTTP response and returns parsed JSON or throws an ApiException.
  dynamic _handleResponse(http.Response response) {
    dynamic body;
    try {
      body = jsonDecode(response.body);
    } catch (_) {
      body = null;
    }

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return body;
    }

    // Handle standard Laravel error responses
    if (response.statusCode == 422 &&
        body is Map &&
        body.containsKey('errors')) {
      final errors = body['errors'] as Map<String, dynamic>;
      final firstMessage = errors.values.first;
      if (firstMessage is List && firstMessage.isNotEmpty) {
        throw ApiException(firstMessage.first.toString(), response.statusCode);
      }
    }

    final message = (body is Map && body['message'] is String)
        ? body['message'] as String
        : 'Request failed with status: ${response.statusCode}';

    throw ApiException(message, response.statusCode);
  }

  void close() {
    _client.close();
  }
}
