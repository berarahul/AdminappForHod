import 'dart:async';
import 'package:attendanceadmin/constant/AppUrl/StudentCard/StudentCardApi.dart';
import 'package:attendanceadmin/viewmodel/service/LoginService/AuthServices.dart';
import 'package:attendanceadmin/viewmodel/service/LoginService/AutharizationHeader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../../../../constant/AppUrl/TeacherCard/TeacherCardAPi.dart';
import '../../../../../../model/LoginModel.dart';
import '../../../../../../model/departmentModel.dart';

class SemesterController extends GetxController {
  final AuthService authService = AuthService();

  final semesterNameController = TextEditingController();

  final Rx<int?> selectedDepartmentId = Rx<int?>(null);
  final Rx<int?> selectedSemesterNumber = Rx<int?>(null);

  final RxList<int> departmentIdList = <int>[].obs;
  final RxList<int> semesterNumberList = List<int>.generate(5, (index) => index + 1).obs; // Populate with 1 to 5

  final RxInt departmentId = 0.obs;
  var departments = <DepartmentModel>[].obs;

  Future<void> fetchDepartments() async {
    try {
      var fetchedDepartments = await ApiHelper().fetchDepartments();
      departments.assignAll(fetchedDepartments);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load departments');
    }
  }

  void setDepartmentId(int department) {
    departmentId.value = department;
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

        // for (var department in bodyDecode) {
        //   departmentIdList.add(department['id']);
        // }
      }
    } else {
      return;
    }
    return null;
  }

  Future<void> addSemester() async {
    final name = semesterNameController.text.trim();
    if (name.isNotEmpty && departmentId.value != null) {
      await ApiHelper.update(
        "${StudentCardApi.addSemesterEndPoint}?sem=$name&deptId=${departmentId.value}",
        headers: await ApiHelper().getHeaders(),
      );
    } else {
      Get.snackbar('Error', 'Please enter a semester name and select a department');
    }
  }

  @override
  void onClose() {
    semesterNameController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    getDepartmentId();
    fetchDepartments();
    super.onInit();
  }
}
