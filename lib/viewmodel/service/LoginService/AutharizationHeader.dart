import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'AuthServices.dart';

class ApiHelper {
  final AuthService authService = AuthService();

  Future<Map<String, String>> getHeaders() async {
    final String? token = authService.getToken();

    if (token == null) {
      throw Exception('Token not found');
    }

    return {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
  }

  static const String baseUrl = 'https://attendancesystem-s1.onrender.com/api/';

  static Future<http.Response> get(
    String endpoint, {
    Map<String, String>? headers,
  }) async {
    final Uri uri = Uri.parse(baseUrl + endpoint);
    return await http.get(uri, headers: headers);
  }

  static Future<void> post(
    String endpoint, {
    Map<String, String>? headers,
    dynamic body,
  }) async {
    final Uri uri = Uri.parse(baseUrl + endpoint);

    final response = await http.post(
      uri,
      headers: headers,
      body: jsonEncode(body),
    );
    if (response.statusCode == 201) {
      print('Data posted successfully');
    } else {
      print('Failed to post data, status code: ${response.statusCode}');
    }
  }

  // Delete method
  static Future<http.Response> delete(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    final Uri uri = Uri.parse(baseUrl + endpoint);

    final response = await http.delete(
      uri,
      headers: headers,
      body: jsonEncode(body),
    );
    return response;
  }

  // Update method
  static Future<http.Response> update(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    final Uri uri = Uri.parse(baseUrl + endpoint);

    final response = await http.put(
      uri,
      headers: headers,
      body: jsonEncode(body),
    );

    return response;
  }
}
