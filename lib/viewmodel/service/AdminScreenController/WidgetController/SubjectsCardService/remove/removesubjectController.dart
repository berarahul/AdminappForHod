import 'dart:async';
import 'dart:convert';

import 'package:attendanceadmin/constant/AppUrl/StudentCard/StudentCardApi.dart';
import 'package:attendanceadmin/constant/AppUrl/SubjectCard/SubjectCardApi.dart';
import 'package:attendanceadmin/constant/AppUrl/TeacherCard/TeacherCardAPi.dart';
import 'package:attendanceadmin/model/login/LoginModel.dart';
import 'package:attendanceadmin/viewmodel/service/LoginService/AuthServices.dart';
import 'package:attendanceadmin/viewmodel/service/LoginService/AutharizationHeader.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../../../model/universalmodel/departmentModel.dart';
import '../../../../../../model/subjectCard/subjectsListModel.dart';

// Controller class for removing students, utilizing GetX for state management.
class RemoveSubjectController extends GetxController {
  // Instance of the authentication service.
  final AuthService authService = AuthService();

  final RxInt departmentId = 0.obs;
  // Rx<int> selectedSubject = 0.obs;

  Rx<Subjectslistmodel?> subjectslistmodel = Subjectslistmodel().obs;
  var departments = <DepartmentModel>[].obs;
  RxList subjects = [].obs;

  RxList<int> subjectId = <int>[].obs;

  RxList<int> selectedSubject = <int>[].obs;


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


  void setDepartmentId(int department) {
    departmentId.value = department;
    print("Department ID set to: $department");
  }

  void toggleIsUserSelected({required int index}) {
    if (selectedSubject.contains(subjectId[index])) {
      selectedSubject.remove(subjectId[index]);
    } else {
      selectedSubject.add(subjectId[index]);
    }

    print("Selected subject: $selectedSubject");
    print("selected department: $departmentId");
  }


  Future<void> fetchAllSubject() async {
    if (departmentId.value != 0) {
      try {
        print('Fetching subjects for department ID: ${departmentId.value}');
        final response = await ApiHelper.get(
          "${StudentCardApi.departmentListEndPoint}/${Subjectcardapi.subjectEndPoint}/${departmentId.value}",
          headers: await ApiHelper().getHeaders(),
        );

        print('API response status code: ${response.statusCode}');
        print('API response body: ${response.body}');

        if (response.statusCode == 200) {
          final Map<String, dynamic> bodyDecode = jsonDecode(response.body);
          subjects.clear();
          subjectId.clear();

          // Corrected the key to "subjects"
          if (bodyDecode.containsKey('subjects')) {
            final List<dynamic> subjectList = bodyDecode['subjects'];
            for (var subject in subjectList) {
              if (subject.containsKey('subName') && subject.containsKey('id')) {
                subjects.add(subject['subName']);
                subjectId.add(subject['id']);
              }
            }
          } else {
            print('Subjects key not found in the response');
          }
          print('Fetched subjects: $subjects');
        } else {
          throw Exception('Failed to fetch subjects: ${response.statusCode}');
        }
      } catch (e) {
        print('Error fetching subjects: $e');
        Get.snackbar('Error', 'Failed to fetch subjects');
      }
    } else {
      Get.snackbar("Error", "Please select the Department");
    }
  }


  Future<void> removeSelectedSubjects() async {
    if (selectedSubject != null && selectedSubject.isNotEmpty && departmentId != null) {
      try {
        // Extract the integer value from the selectedSubject list
        final subjectId = selectedSubject.value.first;
        final deptId = departmentId.value;

        print('Selected subject: $subjectId');
        print('Selected department: $deptId');

        final url = "${Subjectcardapi.subjectDeleteEndpoint}?deptId=$deptId&subjectId=$subjectId";
        print('Request URL: $url');

        final headers = await ApiHelper().getHeaders();
        print('Request Headers: $headers');

        final response = await ApiHelper.delete(
          url,
          headers: headers,
        );

        print('Response Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');

        if (response.statusCode == 200) {
          Get.snackbar("Success", "Selected subject has been removed");
          print("Removed subject: $selectedSubject");

          // Clear selected subject after successful removal
          selectedSubject.clear();
        } else {
          Get.snackbar('Error', 'Failed to remove subjects: ${response.reasonPhrase}');
          print('Failed to remove subjects: ${response.reasonPhrase}');
        }
      } catch (e) {
        print('Error removing subjects: $e');
        Get.snackbar('Error', 'Failed to remove subjects');
      }
    } else {
      Get.snackbar("Something Went Wrong", "Please log out and log in again");
    }
  }



  Future<void> updateList() async {
    subjects.clear();
    selectedSubject.clear();
    await fetchAllSubject();
    print("Updated subject list");
  }

  @override
  void onInit() {
    super.onInit();
    fetchDepartments();

  }

  // Called when the controller is being disposed.
  @override
  void onClose() {
    super.onClose();
    // Ensures selected students are removed when the controller is disposed.
    removeSelectedSubjects();
  }
}
