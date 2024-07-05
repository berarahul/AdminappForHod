import 'dart:async';
import 'dart:convert';
import 'package:attendanceadmin/constant/AppUrl/StudentCard/StudentCardApi.dart';
import 'package:attendanceadmin/constant/AppUrl/TeacherCard/TeacherCardAPi.dart';
import 'package:attendanceadmin/model/LoginModel.dart';
import 'package:attendanceadmin/viewmodel/service/LoginService/AuthServices.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

import '../../../../LoginService/AutharizationHeader.dart';

class RemoveTeacherController extends GetxController {
  final AuthService authService = AuthService();

  RxList<int> departmentIdList = <int>[].obs;
  Rx<int?> selectedDepartmentId = Rx<int?>(null);

  RxList teachers = [].obs;
  RxList<int> teacherIdList = <int>[].obs;
  RxList filteredTeachers = [].obs;
  RxList selectedTeachers = [].obs;

  void toggleIsTeacherSelected({required int index}) {
    var teacher = teachers[index];
    if (selectedTeachers.contains(teacher)) {
      selectedTeachers.remove(teacher);
    } else {
      selectedTeachers.add(teacher);
    }
  }

  void fetchTeachers() {
    Future.delayed(const Duration(seconds: 1), () {
      teachers.clear();
      fetchAllTeachers();
      filteredTeachers.assignAll(teachers);
    });
  }

  void filterSearchResults(String query) {
    if (query.isEmpty) {
      filteredTeachers.assignAll(teachers);
    } else {
      final lowercaseQuery = query.toLowerCase();
      filteredTeachers.assignAll(teachers.where((teacher) => teacher.toLowerCase().contains(lowercaseQuery)));
    }
  }

  void selectAllTeachers(bool selectAll) {
    if (selectAll) {
      selectedTeachers.assignAll(filteredTeachers);
    } else {
      selectedTeachers.clear();
    }
  }

  void addOrRemoveTeacher(String teacher, bool selected) {
    if (selected) {
      if (!selectedTeachers.contains(teacher)) {
        selectedTeachers.add(teacher);
      }
    } else {
      selectedTeachers.remove(teacher);
    }
  }

  FutureOr<void> getDepartmentId() async {
    final UserModel? userModel = authService.getUserModel();
    if (userModel != null) {
      final response = await ApiHelper.get(
        "${Teachercardapi.teacherEndPoint}/${userModel.id}",
        headers: await ApiHelper().getHeaders(),
      );

      if (response.statusCode == 200) {
        final List<dynamic> bodyDecode = jsonDecode(response.body);

        for (var department in bodyDecode) {
          departmentIdList.add(department['id']);
        }
      }
    }
  }

  FutureOr<void> fetchAllTeachers() async {
    if (selectedDepartmentId.value != null) {
      await ApiHelper.get(
        "${Teachercardapi.allTeachersEndpoint}/${selectedDepartmentId.value}",
        headers: await ApiHelper().getHeaders(),
      ).then((value) {
        final List<dynamic> bodyDecode = jsonDecode(value.body);

        for (var teacher in bodyDecode) {
          teachers.add(teacher['teacherId']);
          teacherIdList.add(teacher['name']);
        }
      });
    } else {
      Get.snackbar("Error", "Please select a department");
    }
  }

  Future<void> removeSelectedTeachers() async {
    final UserModel? userModel = authService.getUserModel();

    if (userModel != null) {
      await ApiHelper.delete(StudentCardApi.removeStudentEndPoint,
          headers: await ApiHelper().getHeaders(),
          body: {
            "deptId": selectedDepartmentId.value,
            "rolls": teacherIdList,
          });

      Get.snackbar("Success", "Selected teachers have been removed");
    } else {
      Get.snackbar("Something Went Wrong", "Please log-out and log-in again");
    }
  }

  Future<void> updateList() async {
    teachers.clear();
    selectedTeachers.clear();
    await fetchAllTeachers();
  }

  @override
  void onInit() {
    super.onInit();
    getDepartmentId();
  }

  @override
  void onClose() {
    super.onClose();
    removeSelectedTeachers();
  }
}
