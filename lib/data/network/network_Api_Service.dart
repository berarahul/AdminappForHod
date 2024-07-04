import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../app_exceptions.dart';
import 'base_Api_Service.dart'; // Adjust import as per your project structure

class NetworkApiServices extends BaseApiService {
  @override
  Future<dynamic> getApi(String url) async {
    dynamic jsonResponse;
    if (kDebugMode) {
      print(url);
    }
    try {
      final response =
      await http.get(Uri.parse(url)).timeout(const Duration(seconds: 30));
      jsonResponse = returnResponse(response);
    } on SocketException {
      throw InternetException('No internet connection');
    } on TimeoutException {
      throw RequestTimeOutException('Request timed out');
    }
    return jsonResponse;
  }

  @override
  Future<dynamic> postApi(dynamic data, String url) async {
    dynamic jsonResponse;
    if (kDebugMode) {
      print('URL: $url');
      print('Data: $data');
    }
    try {
      final response = await http
          .post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      )
          .timeout(const Duration(seconds: 30));

      jsonResponse = returnResponse(response);
    } on SocketException {
      throw InternetException('No internet connection');
    } on TimeoutException {
      throw RequestTimeOutException('Request timed out');
    }
    return jsonResponse;
  }

  @override
  Future<dynamic> putApi(dynamic data, String url) async {
    dynamic jsonResponse;
    if (kDebugMode) {
      print('URL: $url');
      print('Data: $data');
    }
    try {
      final response = await http
          .put(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      )
          .timeout(const Duration(seconds: 30));

      jsonResponse = returnResponse(response);
    } on SocketException {
      throw InternetException('No internet connection');
    } on TimeoutException {
      throw RequestTimeOutException('Request timed out');
    }
    return jsonResponse;
  }

  @override
  Future<dynamic> deleteApi(String url) async {
    dynamic jsonResponse;
    if (kDebugMode) {
      print(url);
    }
    try {
      final response =
      await http.delete(Uri.parse(url)).timeout(const Duration(seconds: 30));
      jsonResponse = returnResponse(response);
    } on SocketException {
      throw InternetException('No internet connection');
    } on TimeoutException {
      throw RequestTimeOutException('Request timed out');
    }
    return jsonResponse;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return jsonDecode(response.body);
      case 400:
        throw InvalidUrlException('Invalid URL');
      default:
        throw FetchDataException(
            'Error occurred while communicating with server: ${response.statusCode}');
    }
  }
}
