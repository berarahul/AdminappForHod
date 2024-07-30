import 'dart:async';
import 'dart:convert';
import 'package:attendanceadmin/constant/AppUrl/StudentCard/StudentCardApi.dart';
import 'package:attendanceadmin/constant/AppUrl/TeacherCard/TeacherCardAPi.dart';
import 'package:attendanceadmin/model/login/LoginModel.dart';
import 'package:attendanceadmin/viewmodel/service/LoginService/AuthServices.dart';
import 'package:attendanceadmin/viewmodel/service/LoginService/AutharizationHeader.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:http/http.dart' as http;

import '../../../../../../model/universalmodel/departmentModel.dart';

class RemoveStudentController extends GetxController {
  final AuthService authService = AuthService();

  RxList<int> semesters = [1, 2, 3, 4, 5, 6].obs;

  RxList<int> rollNumList = <int>[].obs;

  Rx<int?> selectedSemester = Rx<int?>(null);

  RxList students = [].obs;

  RxList<int> studentRollNumber = <int>[].obs;

  RxList<int> selectedStudents = <int>[].obs;

  var departments = <DepartmentModel>[].obs;

  final RxInt departmentId = 0.obs;

  void toggleIsUserSelected({required int index}) {
    if (selectedStudents.contains(studentRollNumber[index])) {
      selectedStudents.remove(studentRollNumber[index]);
    } else {
      selectedStudents.add(studentRollNumber[index]);
    }

    print("Selected students: $selectedStudents");
  }

  void setDepartmentId(int department) {
    departmentId.value = department;
    print("Department ID set to: $department");
  }

  void fetchStudents(int semester) {
    print("Fetching students for semester: $semester");
    Future.delayed(const Duration(seconds: 1), () {
      students.clear();
      fetchAllStudent();
    });
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
        print("Fetched department ID: ${bodyDecode[0]['id']}");
      }
    } else {
      return;
    }
  }

  Future<void> fetchAllStudent() async {
    if (selectedSemester.value != null) {
      try {
        final response = await ApiHelper.get(
          "${StudentCardApi.studentListEndPoint}/$departmentId/$selectedSemester",
          headers: await ApiHelper().getHeaders(),
        );

        if (response.statusCode == 200) {
          final List<dynamic> bodyDecode = jsonDecode(response.body);
          students.clear();
          studentRollNumber.clear();

          for (var student in bodyDecode) {
            students.add(student['name']);
            studentRollNumber.add(student['roll']);
          }
          print("Fetched students: $students");
        } else {
          throw Exception('Failed to fetch students: ${response.statusCode}');
        }
      } catch (e) {
        print('Error fetching students: $e');
        Get.snackbar('Error', 'Failed to fetch students');
      }
    } else {
      Get.snackbar("Error", "Please select the semester");
    }
  }

  Future<void> removeSelectedStudents() async {
    final UserModel? userModel = authService.getUserModel();

    if (userModel != null) {
      try {
        await ApiHelper.delete(
          StudentCardApi.removeStudentEndPoint,
          headers: await ApiHelper().getHeaders(),
          body: {
            "semester": selectedSemester.value,
            "deptId": departmentId.value,
            "rolls": selectedStudents.toList(),
          },
        );

        Get.snackbar("Success", "Selected students have been removed");
        print("Removed students: $selectedStudents");

        // Clear selected students after successful removal
        selectedStudents.clear();
      } catch (e) {
        print('Error removing students: $e');
        Get.snackbar('Error', 'Failed to remove students');
      }
    } else {
      Get.snackbar("Something Went Wrong", "please log-out and log-in again");
    }
  }

  Future<void> fetchDepartments() async {
    try {
      var fetchedDepartments = await ApiHelper().fetchDepartments();
      departments.assignAll(fetchedDepartments);
      print("Fetched departments: $departments");
    } catch (e) {
      print('Error fetching departments: $e');
      Get.snackbar('Error', 'Failed to load departments');
    }
  }

  Future<void> updateList() async {
    students.clear();
    selectedStudents.clear();
    await fetchAllStudent();
    print("Updated student list");
  }

  @override
  void onInit() {
    super.onInit();
    getDepartmentId();
    fetchDepartments();
  }

  @override
  void onClose() {
    super.onClose();
    removeSelectedStudents();
  }
}
