import 'dart:async';
import 'dart:convert';

import 'package:attendanceadmin/viewmodel/service/LoginService/AuthServices.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../constant/AppUrl/StudentCard/StudentCardApi.dart';
import '../../../../../../constant/AppUrl/SubjectCard/SubjectCardApi.dart';
import '../../../../../../constant/AppUrl/TeacherCard/TeacherCardAPi.dart';
import '../../../../../../model/LoginModel.dart';
import '../../../../LoginService/AutharizationHeader.dart';

class UpdateTeacherController extends GetxController {

  TextEditingController nameController = TextEditingController();
  TextEditingController teacherIdController = TextEditingController();

  final AuthService authService = AuthService();

  RxList<int> departmentIdList = <int>[].obs;
  RxList<String> subjectsList = <String>[].obs;
  RxList<int> selectedSubjectIds = <int>[].obs;
  RxList<String> teacherList = <String>[].obs;
  RxList<int> teacherId = <int>[].obs;
  Rx<int?> selectedDepartmentId = Rx<int?>(null);
  RxList<String> newSelectedSubjectIds = <String>[].obs;
  RxList<String> removeSelectedSubjectIds = <String>[].obs;

  @override
  void onInit() {

    getDepartmentId();
    super.onInit();
  }

  FutureOr<void> getDepartmentId() async {
    final UserModel? userModel = authService.getUserModel();
    if (userModel != null) {
      final response = await ApiHelper.get(
        "${Teachercardapi.teacherEndPoint}/${userModel.id}",
        headers: await ApiHelper().getHeaders(),
      );

      if (response.statusCode != 200) {
        return;
      } else {
        final List<dynamic> bodyDecode = jsonDecode(response.body);
        for (var department in bodyDecode) {
          departmentIdList.add(department['id']);
        }
      }
    }
  }

  Future<void> fetchallSubjects() async {
    try {
      if (selectedDepartmentId.value == null) {
        print('Error: Selected department ID is null');
        return;
      }

      String endpoint =
          "${StudentCardApi.departmentListEndPoint}/${Subjectcardapi.subjectEndPoint}/${selectedDepartmentId.value}";

      var response = await ApiHelper.get(endpoint,
          headers: await ApiHelper().getHeaders());

      if (response.statusCode == 200) {
        Map<String, dynamic> decodedData = jsonDecode(response.body);

        if (decodedData.containsKey('subjects') &&
            decodedData['subjects'] is List) {
          List<dynamic> subjectsListResponse = decodedData['subjects'];

          subjectsList.clear();

          for (var subject in subjectsListResponse) {
            String subjectId =
            subject['subjectId'].toString(); // Assuming subjectId is an int
            subjectsList.add(subjectId);
          }
        } else {
          print(
              'Error: Invalid response format - subjects key not found or not a list');
        }
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching subjects: $e');
    }
  }

  FutureOr<void> fetchAllTeacher() async {
    if (teacherList.isNotEmpty) {
      teacherList.clear();
    } else {
      if (selectedDepartmentId.value != null) {
        await ApiHelper.get(
          "${Teachercardapi.allTeachersEndpoint}$selectedDepartmentId",
          headers: await ApiHelper().getHeaders(),
        ).then((value) {
          final List<dynamic> bodyDecode = jsonDecode(value.body);

          for (var teacher in bodyDecode) {
            teacherList.add(teacher['name']);
            teacherId.add(teacher['teacherId']);
          }
        });
      } else {
        Get.snackbar('Error', 'Please select department');
      }
    }
  }

  FutureOr<void> updatedTeacher() async {
    if (selectedDepartmentId.value != null) {
      final data = await ApiHelper.update(
        Teachercardapi.updateTeacherEndPoint,
        headers: await ApiHelper().getHeaders(),
        body: {

          "teacherId": int.parse(teacherIdController.text),
          "name": nameController.text,
        },
      );

      if (data.statusCode == 200) {
        Get.snackbar('Success', 'Student updated successfully');

        nameController.clear();
        teacherIdController.clear();
        teacherList.clear();
        teacherId.clear();

        await fetchAllTeacher();
        Get.back();
      } else {
        Get.snackbar('Error', 'Failed to update student');
      }
    }
  }
}




















