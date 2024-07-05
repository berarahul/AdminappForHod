import 'dart:async';
import 'dart:convert';

import 'package:attendanceadmin/viewmodel/service/LoginService/AuthServices.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../constant/AppUrl/StudentCard/StudentCardApi.dart';
import '../../../../../../constant/AppUrl/TeacherCard/TeacherCardAPi.dart';
import '../../../../../../model/LoginModel.dart';
import '../../../../LoginService/AutharizationHeader.dart';

class UpdateStudentController extends GetxController {
  TextEditingController departmentController = TextEditingController();

  TextEditingController semesterController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController rollController = TextEditingController();

  final AuthService authService = AuthService();

  Rx<int?> selectedDepartment = Rx<int?>(null);

  Rx<int?> selectedSemester = Rx<int?>(null);

  RxList<int> departmentIdList = <int>[].obs;
  RxList<int> semestersList = <int>[1, 2, 3, 4, 5, 6].obs;

  RxList<String> studentsList = <String>[].obs;

  RxList<int> studentRollNumber = <int>[].obs;

  FutureOr<void> getDepartmentId() async {
    //
    final UserModel? userModel = authService.getUserModel();
    if (userModel != null) {
      //
      final response = await ApiHelper.get(
        "${Teachercardapi.teacherEndPoint}/${userModel.id}",
        headers: await ApiHelper().getHeaders(),
      );

      if (response.statusCode != 200) {
        return;
      } else {
        // Add this line to debug
        final List<dynamic> bodyDecode = jsonDecode(response.body);

        // Assuming you want to process each department
        for (var department in bodyDecode) {
          departmentIdList.add(department['id']);
        }
      }
    } else {
      return;
    }
    return null;
  }

  FutureOr<void> fetchAllStudent() async {
    if (studentsList.isNotEmpty) {
      studentsList.clear();
    } else {
      if (selectedSemester.value != null) {
        await ApiHelper.get(
          "${StudentCardApi.studentListEndPoint}/$selectedDepartment/$selectedSemester",
          headers: await ApiHelper().getHeaders(),
        ).then((value) {
          final List<dynamic> bodyDecode = jsonDecode(value.body);

          for (var student in bodyDecode) {
            studentsList.add(student['name']);

            studentRollNumber.add(student['roll']);
          }
        });
      } else {
        Get.snackbar('Error', 'Please select semester');
      }
    }
  }

  FutureOr<void> updatedStudent() async {
    if (selectedSemester.value != null) {
      final data = await ApiHelper.update(
        StudentCardApi.updateStudentEndPoint,
        headers: await ApiHelper().getHeaders(),
        body: {
          "deptId": int.parse(departmentController.text),
          "semesterId": int.parse(semesterController.text),
          "roll": int.parse(rollController.text),
          "name": nameController.text,
        },
      );

      if (data.statusCode == 200) {
        Get.snackbar('Success', 'Student updated successfully');

        departmentController.clear();

        semesterController.clear();

        nameController.clear();

        rollController.clear();

        studentsList.clear();

        studentRollNumber.clear();

        await fetchAllStudent();

        Get.back();
      } else {
        Get.snackbar('Error', 'Failed to update student');
      }
    }
  }

  @override
  void onInit() {
    getDepartmentId();
    super.onInit();
  }
}
