import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:attendanceadmin/constant/AppUrl/StudentCard/StudentCardApi.dart';
import 'package:get/get.dart';

import '../../../../../../constant/AppUrl/TeacherCard/TeacherCardAPi.dart';
import '../../../../../../model/LoginModel.dart';
import '../../../../LoginService/AuthServices.dart';
import '../../../../LoginService/AutharizationHeader.dart';

class RemoveStudentControllerFromLastSem extends GetxController {
  final AuthService authService = AuthService();

  // Observable list of department IDs. Initially null.
  RxList departmentIdList = [].obs;

  RxList<String> students = <String>[].obs;

  RxList<int> studentRollNumber = <int>[].obs;

  RxList<String> selectedStudent = <String>[].obs;

  RxList<int> selectedStudentRollNumber = <int>[].obs;

  // Observable for tracking the selected department ID. Initially null.
  Rx<int?> selectedDepartmentId = Rx<int?>(null);

  void toggleSlectedStudent(String student) {
    if (selectedStudent.contains(student)) {
      selectedStudent.remove(student);
    } else {
      selectedStudent.add(student);
    }
  }

  void toggleSelectedStudentRollNumber(int rollNumber) {
    if (selectedStudentRollNumber.contains(rollNumber)) {
      selectedStudentRollNumber.remove(rollNumber);
    } else {
      selectedStudentRollNumber.add(rollNumber);
    }
  }

  void selectAllStudent() {
    if (students.isNotEmpty) {
      if (students.length == selectedStudent.length) {
        selectedStudent.clear();
      } else {
        selectedStudent.clear();
        selectedStudent.addAll(students);
      }
    }
  }

  void selectAllStudentRollNumber() {
    if (studentRollNumber.isNotEmpty) {
      if (studentRollNumber.length == selectedStudentRollNumber.length) {
        selectedStudentRollNumber.clear();
      } else {
        selectedStudentRollNumber.clear();
        selectedStudentRollNumber.addAll(studentRollNumber);
      }
    }
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

      if (response.statusCode == 200) {
        final List<dynamic> bodyDecode = jsonDecode(response.body);

        // Assuming you want to process each department
        for (var department in bodyDecode) {
          departmentIdList.add(department['id']);
        }
      } else {
        print('Error: ${response.statusCode}');
      }
    } else {
      return;
    }
    return null;
  }

  FutureOr<void> fetchAllStudent() async {
    final data = await ApiHelper.get(
      "${StudentCardApi.studentListEndPoint}/$selectedDepartmentId/6",
      headers: await ApiHelper().getHeaders(),
    );

    if (data.statusCode == 200) {
      final List<dynamic> bodyDecode = jsonDecode(data.body);

      print(bodyDecode);

      for (var student in bodyDecode) {
        students.add(student['name']);

        studentRollNumber.add(student['roll']);
      }
    } else {
      print('Error: ${data.statusCode}');
    }
  }

  FutureOr<void> removeStudentFromLastSem() async {
    if (selectedDepartmentId.value != null) {
      final url = Uri.parse(
          "${ApiHelper.baseUrl}${StudentCardApi.removeLastSemStudentEndPoint}?deptId=$selectedDepartmentId");

      final response = await http.delete(
        url,
        headers: await ApiHelper().getHeaders(),
        body: jsonEncode(selectedStudentRollNumber),
      );

      if (response.statusCode == 200) {
        Get.snackbar(
          "Success",
          "Students removed successfully",
          snackPosition: SnackPosition.BOTTOM,
        );

        reset();
      } else {
        Get.snackbar(
          "Error",
          "Something went wrong! Please try again later.",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } else {
      Get.snackbar(
        "Error",
        "Please select the department",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void reset() {
    students.clear();
    selectedStudent.clear();
    studentRollNumber.clear();
    selectedStudentRollNumber.clear();
    selectedDepartmentId.value = null;
  }

  @override
  void onInit() {
    getDepartmentId();
    super.onInit();
  }
}
