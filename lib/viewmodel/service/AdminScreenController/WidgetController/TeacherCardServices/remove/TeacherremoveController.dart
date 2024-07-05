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

  RxInt selectedTeacher = 0.obs;

  RxList<Map<String, dynamic>> teachersList = <Map<String, dynamic>>[].obs;

  void toogleSelectAndUnselect({required int teacherId}) {
    selectedTeacher.value == teacherId
        ? selectedTeacher.value = 0
        : selectedTeacher.value = teacherId;
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
    if (teacherIdList.isNotEmpty) {
      teacherIdList.clear();
    } else {
      if (selectedDepartmentId.value != null) {
        await ApiHelper.get(
          "${Teachercardapi.allTeachersEndpoint}${selectedDepartmentId.value}",
          headers: await ApiHelper().getHeaders(),
        ).then((value) {
          final List<dynamic> bodyDecode = jsonDecode(value.body);

          for (var teacher in bodyDecode) {
            teachersList.add({
              "teacherId": teacher['teacherId'],
              "name": teacher['name'],
            });
          }
        });
      } else {
        Get.snackbar("Error", "Please select a department");
      }
    }
  }

  Future<void> removeSelectedTeachers() async {
    final UserModel? userModel = authService.getUserModel();

    if (userModel != null) {
      final data = await ApiHelper.delete(
        "${Teachercardapi.removeTeacherEndpoint}$selectedTeacher",
        headers: await ApiHelper().getHeaders(),
      );

      if (data.statusCode == 200) {
        Get.snackbar("Success", "Teacher removed successfully");
        updateList();
      } else {
        Get.snackbar("Error", "Something went wrong");

        print(data.body);
      }
    } else {
      Get.snackbar("Something Went Wrong", "Please log-out and log-in again");
    }
  }

  Future<void> updateList() async {
    teachers.clear();
    teachersList.clear();
    selectedTeacher = 0.obs;
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
