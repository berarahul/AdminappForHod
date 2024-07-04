import 'dart:async';
import 'dart:convert';

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

  // Observable for tracking the selected department ID. Initially null.
  Rx<int?> selectedDepartmentId = Rx<int?>(null);

  void toggleSlectedStudent(String student) {
    if (selectedStudent.contains(student)) {
      selectedStudent.remove(student);
    } else {
      selectedStudent.add(student);
    }
  }

  void selectAllStudent() {
    if (students.length == selectedStudent.length) {
      selectedStudent.clear();
    } else {
      selectedStudent.clear();
      selectedStudent.addAll(students);
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
    await ApiHelper.get(
      "${StudentCardApi.studentListEndPoint}/$selectedDepartmentId/6",
      headers: await ApiHelper().getHeaders(),
    ).then((value) {
      final List<dynamic> bodyDecode = jsonDecode(value.body);

      for (var student in bodyDecode) {
        students.add(student['name']);

        studentRollNumber.add(student['roll']);
      }
    });
  }

  FutureOr<void> removeStudentFromLastSem() async {
    await ApiHelper.delete(
      "${StudentCardApi.removeLastSemStudentEndPoint}?deptId=$selectedDepartmentId",
      headers: await ApiHelper().getHeaders(),
      body: {},
    );
  }

  @override
  void onInit() {
    getDepartmentId();
    super.onInit();
  }
}
