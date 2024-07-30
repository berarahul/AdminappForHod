import 'dart:convert';
import 'dart:developer';

import 'package:attendanceadmin/constant/AppUrl/StudentCard/StudentCardApi.dart';
import 'package:attendanceadmin/constant/AppUrl/SubjectCard/SubjectCardApi.dart';
import 'package:attendanceadmin/model/login/LoginModel.dart';
import 'package:attendanceadmin/model/subjectCard/subjectsListModel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../constant/AppUrl/TeacherCard/TeacherCardAPi.dart';
import '../../../model/subjectCard/papperCodeNameModel.dart';
import '../../../model/universalmodel/departmentModel.dart';
import '../AdminScreenController/WidgetController/TeacherCardServices/update/TeacherUpdateController.dart';
import 'AuthServices.dart';

class ApiHelper {
  final AuthService authService = AuthService();
  final UpdateTeacherController updateTeacherController= UpdateTeacherController();


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
      Get.snackbar("Success", "Data Posted Successfully");
      print('Data posted successfully');
    } else {
      // Get.snackbar("OOps", "Failed to Post Data");
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

  Future<List<DepartmentModel>> fetchDepartments() async {
    final UserModel? userModel = authService.getUserModel();
    final headers = await getHeaders();
    final response = await get(
        "${Teachercardapi.teacherEndPoint}/${userModel?.id}",
        headers: headers);

    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((item) => DepartmentModel.fromJson(item)).toList();
    } else {
      print("Error $response");
      throw Exception('Failed to load departments');
    }
  }




  Future<List<PaperCodeNameModel>> fetchPaperCodeNameByAPi() async {


    final headers = await getHeaders();
    final response = await get(
        "${Subjectcardapi.paperCodeNameView}",
        headers: headers);

    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((item) => PaperCodeNameModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load PaperCodeName');
    }
  }




}





