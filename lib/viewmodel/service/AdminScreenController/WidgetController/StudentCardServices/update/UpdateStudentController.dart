import 'dart:async';
import 'dart:convert';

import 'package:attendanceadmin/viewmodel/service/LoginService/AuthServices.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../constant/AppUrl/StudentCard/StudentCardApi.dart';
import '../../../../../../constant/AppUrl/TeacherCard/TeacherCardAPi.dart';
import '../../../../../../model/LoginModel.dart';
import '../../../../../../model/departmentModel.dart';
import '../../../../LoginService/AutharizationHeader.dart';

class UpdateStudentController extends GetxController {
  TextEditingController departmentController = TextEditingController();

  TextEditingController semesterController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController rollController = TextEditingController();

  final AuthService authService = AuthService();
  final RxInt departmentId = 0.obs;
  var departments = <DepartmentModel>[].obs;
  Rx<int?> selectedDepartment = Rx<int?>(null);

  Rx<int?> selectedSemester = Rx<int?>(null);

  RxList<int> departmentIdList = <int>[].obs;
  RxList<int> semestersList = [1, 2, 3, 4, 5, 6].obs;

  RxList studentsList = [].obs;

  RxList<int> studentRollNumber = <int>[].obs;






  Future<void> fetchDepartments() async {
    try {
      var fetchedDepartments = await ApiHelper().fetchDepartments();
      departments.assignAll(fetchedDepartments);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load departments');
    }
  }








  void fetchStudents(int semester) {
    print("Fetching students for semester: $semester");
    Future.delayed(const Duration(seconds: 1), () {
      studentsList.clear();
      fetchAllStudent();
    });
  }







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
        // for (var department in bodyDecode) {
        //   departmentIdList.add(department['id']);
        // }
      }
    } else {
      return;
    }
    return null;
  }
  void setDepartmentId(int department) {
    departmentId.value = department;
  }

  FutureOr<void> fetchAllStudent() async {
    print("fetching all students");
    if (studentsList.isNotEmpty) {
      studentsList.clear();
      print("if part");
    } else {
      print("else part");
      if (selectedSemester.value != null) {
        print(selectedSemester.value);
        await ApiHelper.get(
          "${StudentCardApi.studentListEndPoint}/$departmentId/$selectedSemester",
          headers: await ApiHelper().getHeaders(),
        ).then((value) {
          final List<dynamic> bodyDecode = jsonDecode(value.body);
print(bodyDecode);
          for (var student in bodyDecode) {
            studentsList.add(student['name']);
 print(studentsList);
            studentRollNumber.add(student['roll']);
            print(studentRollNumber);
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
    fetchDepartments();
    super.onInit();
  }
}
