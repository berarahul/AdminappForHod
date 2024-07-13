
import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../../model/login/LoginModel.dart';

class AuthService {
  final GetStorage storage = GetStorage();
  final String baseUrl = 'https://attendancesystem-s1.onrender.com';

  Future<UserModel?> login(String username, String password) async {
    final String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    final response = await http.get(
      Uri.parse('$baseUrl/user'),
      headers: {'Authorization': basicAuth},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final int userId = data['id'];
      final String userName = data['name'];

      // Extract the token from the headers
      final token =
          response.headers['authorization']?.replaceFirst('Bearer ', '');
      print("Extracted token from headers: $token");

      if (token != null && token.split('.').length == 3) {
        try {
          // Decode the payload without verifying the token
          final parts = token.split('.');
          final payload = jsonDecode(
              utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));
          print("Decoded Token Payload: $payload");

          // Ensure authorities are parsed correctly as List<String>
          final List<String> authorities = (payload['authorities'] != null &&
                  payload['authorities'] is String)
              ? (payload['authorities'] as String)
                  .split(',') // Split string into list of authorities
              : <String>[]; // Default empty list if authorities field is missing or not a string

          // Check if the token contains required authorities
          if (authorities.contains('TEACHER') && authorities.contains('HOD')) {
            // Convert the decoded payload to UserModel
            final userModel = UserModel(
              id: userId,
              name: userName,
              username: username,
            );

            await storage.write('token', token);
            await storage.write('userModel', userModel.toJson());

            return userModel;
          } else {
            throw Exception('Unauthorized access');
          }
        } catch (e) {
          print('JWT decoding failed: $e');
          throw Exception('Invalid token');
        }
      } else {
        throw Exception('Token not found in API response or invalid format');
      }
    } else {
      throw Exception('Invalid Login Credentials');
    }
  }

  bool isLoggedIn() {
    String? token = storage.read('token');
    if (token != null) {
      return true;
    } else {
      return false;
    }
  }

  String? getToken() {
    final String? token = storage.read('token');
    if (token != null) {
      return token;
    }
    return null;
  }

  UserModel? getUserModel() {
    final json = storage.read('userModel');

    if (json != null) {
      return UserModel.fromJson(json);
    }
    return null;
  }

  Future<void> logout() async {
    await storage.erase();
  }
}
