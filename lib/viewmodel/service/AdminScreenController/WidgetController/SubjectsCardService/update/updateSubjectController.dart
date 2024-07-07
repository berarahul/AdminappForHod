// import 'dart:async';
// import 'dart:convert';
//
// import 'package:attendanceadmin/constant/AppUrl/SubjectCard/SubjectCardApi.dart';
// import 'package:attendanceadmin/viewmodel/service/LoginService/AuthServices.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../../../../constant/AppUrl/StudentCard/StudentCardApi.dart';
// import '../../../../../../constant/AppUrl/TeacherCard/TeacherCardAPi.dart';
// import '../../../../../../model/LoginModel.dart';
// import '../../../../../../model/departmentModel.dart';
// import '../../../../../../model/subjectsListModel.dart';
// import '../../../../LoginService/AutharizationHeader.dart';
//
// class UpdateSubjectController extends GetxController {
//   TextEditingController departmentController = TextEditingController();
//
//   TextEditingController semesterController = TextEditingController();
//   TextEditingController nameController = TextEditingController();
//   TextEditingController rollController = TextEditingController();
//
//   final AuthService authService = AuthService();
//
//
//
//
//
//   RxList<int> studentRollNumber = <int>[].obs;
//
//   final RxInt departmentId = 0.obs;
//   Rx<Subjectslistmodel?> subjectslistmodel = Subjectslistmodel().obs;
//   var departments = <DepartmentModel>[].obs;
//
//   void setDepartmentId(int department) {
//     departmentId.value = department;
//     print(department);
//   }
//
//   @override
//   void onInit() {
//     getDepartmentId();
//
//     fetchDepartments();
//     super.onInit();
//   }
//
//   Future<void> fetchDepartments() async {
//     try {
//       var fetchedDepartments = await ApiHelper().fetchDepartments();
//       departments.assignAll(fetchedDepartments);
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to load departments');
//     }
//   }
//
//
//   FutureOr<void> getDepartmentId() async {
//     //
//     final UserModel? userModel = authService.getUserModel();
//     if (userModel != null) {
//       //
//       final response = await ApiHelper.get(
//         "${Teachercardapi.teacherEndPoint}/${userModel.id}",
//         headers: await ApiHelper().getHeaders(),
//       );
//
//       if (response.statusCode != 200) {
//         return;
//       } else {
//         // Add this line to debug
//         final List<dynamic> bodyDecode = jsonDecode(response.body);
//
//         // Assuming you want to process each department
//         // for (var department in bodyDecode) {
//         //   departmentIdList.add(department['id']);
//         // }
//       }
//     } else {
//       return;
//     }
//     return null;
//   }
//
//   Future<void> fetchallSubjects() async {
//     try {
//       if (departmentId.value == null) {
//         print("department id null");
//         return;
//       }
//       String endpoint =
//           "${StudentCardApi.departmentListEndPoint}/${Subjectcardapi.subjectEndPoint}/${departmentId.value}";
//       var response = await ApiHelper.get(endpoint,
//           headers: await ApiHelper().getHeaders());
//       if (response.statusCode == 200) {
//         final decodedData = jsonDecode(response.body);
//         // Check if decodedData is not null and properly formatted before assigning
//         if (decodedData != null && decodedData is Map<String, dynamic>) {
//           subjectslistmodel.value = Subjectslistmodel.fromJson(decodedData);
//         } else {
//           // Assign a default value or handle the null case
//           subjectslistmodel.value = Subjectslistmodel();
//           print(subjectslistmodel.value);
//         }
//       } else {
//         print(
//             'Error: Invalid response format - subjects key not found or not a list');
//       }
//     } catch (e) {
//       print('Error fetching subjects: $e');
//     }
//   }
//   FutureOr<void> updatedStudent() async {
//
//       final data = await ApiHelper.update(
//         StudentCardApi.updateStudentEndPoint,
//         headers: await ApiHelper().getHeaders(),
//         body: {
//           "deptId": int.parse(departmentController.text),
//           "semesterId": int.parse(semesterController.text),
//           "roll": int.parse(rollController.text),
//           "name": nameController.text,
//         },
//       );
//
//       if (data.statusCode == 200) {
//         Get.snackbar('Success', 'Student updated successfully');
//
//         departmentController.clear();
//
//         semesterController.clear();
//
//         nameController.clear();
//
//         rollController.clear();
//
//         // subjectslistmodel.clear();
//
//         studentRollNumber.clear();
//
//         await fetchallSubjects();
//
//         Get.back();
//       } else {
//         Get.snackbar('Error', 'Failed to update student');
//       }
//     }
//   }
//








import 'dart:async';
import 'dart:convert';

import 'package:attendanceadmin/model/subjectsListModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../../constant/AppUrl/StudentCard/StudentCardApi.dart';
import '../../../../../../constant/AppUrl/SubjectCard/SubjectCardApi.dart';
import '../../../../../../model/departmentModel.dart';
import '../../../../LoginService/AuthServices.dart';
import '../../../../LoginService/AutharizationHeader.dart';

class Updatesubjectcontroller extends GetxController{



  TextEditingController subjectIdController= TextEditingController();
  TextEditingController subjectNameController= TextEditingController();
  TextEditingController departmentIdController= TextEditingController();
  TextEditingController semesterIdController= TextEditingController();
  TextEditingController paperCodeController= TextEditingController();



  final AuthService authService = AuthService();
  final RxInt departmentId = 0.obs;
  var departments = <DepartmentModel>[].obs;

  // Rx<Subjectslistmodel?> subjectslistmodel = Subjectslistmodel().obs;
  Rx<Subjectslistmodel?> subjectslistmodel = Rx<Subjectslistmodel?>(null);
  Rx<int> selectedSubject = 0.obs;

  // Variables to store subjectId and semesterId
  int selectedSubjectId = 0;
  int selectedSemesterId = 0;

  // RxLists to store names, semesterIds, and subjectIds
  RxList<String> subjectNames = RxList<String>();
  RxList<int> semesterIds = RxList<int>();
  RxList<int> subjectIds = RxList<int>();






  void onInit() {
    // getDepartmentId();

    fetchDepartments();
    super.onInit();
  }


// set the Department id
  void setDepartmentId(int department) {
     departmentId.value = department;
     print(department);
     fetchallSubjects();
 }


 // Department fetch from ApiHelper
  Future<void> fetchDepartments() async {
     try {
       var fetchedDepartments = await ApiHelper().fetchDepartments();
       departments.assignAll(fetchedDepartments);
     } catch (e) {
       Get.snackbar('Error', 'Failed to load departments');
   }
  }








  // Fetch all subjects for editing
  Future<void> fetchallSubjects() async {
    try {
      if (departmentId.value == null) {
        print("department id null");
        return;
      }
      String endpoint =
          "${StudentCardApi.departmentListEndPoint}/${Subjectcardapi.subjectEndPoint}/${departmentId.value}";
      var response = await ApiHelper.get(endpoint,
          headers: await ApiHelper().getHeaders());
      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        // Check if decodedData is not null and properly formatted before assigning
        if (decodedData != null && decodedData is Map<String, dynamic>) {
          subjectslistmodel.value = Subjectslistmodel.fromJson(decodedData);

          // Clear previous data
          subjectNames.clear();
          semesterIds.clear();
          subjectIds.clear();

          // Extract and store subjectId, semesterId, and names in variables
          if (subjectslistmodel.value?.subjects != null) {
            subjectslistmodel.value!.subjects!.forEach((subject) {
              if (subject.id != null) {
                selectedSubjectId = subject.id!;
                subjectIds.add(subject.id!);
                print('Subject ID: ${subject.id}');
              }
              if (subject.semesterId != null) {
                selectedSemesterId = subject.semesterId!;
                semesterIds.add(subject.semesterId!);
                print('Semester ID: ${subject.semesterId}');
              }
              if (subject.subName != null) {
                subjectNames.add(subject.subName!);
                print('Subject Name: ${subject.subName}');
              }
            });
          } else {
            print('No subjects found');
          }

          // You now have the subjectIds, semesterIds, and names in respective RxLists
          print('Subject IDs: $subjectIds');
          print('Semester IDs: $semesterIds');
          print('Subject Names: $subjectNames');
        } else {
          // Assign a default value or handle the null case
          subjectslistmodel.value = Subjectslistmodel();
          print(subjectslistmodel.value);
        }
      } else {
        print('Error: Invalid response format - subjects key not found or not a list');
      }
    } catch (e) {
      print('Error fetching subjects: $e');
    }
  }



  Future<void> updatedSubject() async {
    try {
      if (departmentId.value != null) {
        final data = await ApiHelper.update(
          Subjectcardapi.subjectUpdateEndpoint,
          headers: await ApiHelper().getHeaders(),
          body: {
            "id": int.parse(subjectIdController.text),
            "name": subjectNameController.text,
            "deptId": int.parse(departmentIdController.text),
            "semesterId": int.parse(semesterIdController.text),
          },
        );

        // Print the response details for debugging
        print('Response Status Code: ${data.statusCode}');
        print('Response Body: ${data.body}');

        if (data.statusCode == 200) {
          Get.snackbar('Success', 'Subject updated successfully');

          // Clear controllers after successful update
          subjectIdController.clear();
          subjectNameController.clear();
          departmentIdController.clear();
          semesterIdController.clear();

          // Refresh subject list after update
          await fetchallSubjects();

          // Navigate back after successful update
          Get.back();
        } else {
          Get.snackbar('Error', 'Failed to update subject');
          print('Error: ${data.body}');
        }
      } else {
        Get.snackbar('Error', 'Department ID is null');
      }
    } catch (e) {
      print('Error updating subject: $e');
      Get.snackbar('Error', 'Failed to update subject: $e');
    }
  }




}



