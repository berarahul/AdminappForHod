// import 'dart:async';
// import 'dart:convert';
// import 'package:attendanceadmin/model/subjectCard/subjectsListModel.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:get/get_rx/get_rx.dart';
// import 'package:get/get_rx/src/rx_types/rx_types.dart';
//
// import '../../../../../../constant/AppUrl/StudentCard/StudentCardApi.dart';
// import '../../../../../../constant/AppUrl/SubjectCard/SubjectCardApi.dart';
// import '../../../../../../model/subjectCard/papperCodeNameModel.dart';
// import '../../../../../../model/universalmodel/departmentModel.dart';
// import '../../../../LoginService/AuthServices.dart';
// import '../../../../LoginService/AutharizationHeader.dart';
//
// class Updatesubjectcontroller extends GetxController {
//   TextEditingController subjectIdController = TextEditingController();
//   TextEditingController subjectNameController = TextEditingController();
//   TextEditingController departmentIdController = TextEditingController();
//   TextEditingController semesterIdController = TextEditingController();
//   TextEditingController paperNameController = TextEditingController();
//
//   final AuthService authService = AuthService();
//   final RxInt departmentId = 0.obs;
//   var departments = <DepartmentModel>[].obs;
//
//   Rx<Subjectslistmodel?> subjectslistmodel = Rx<Subjectslistmodel?>(null);
//   Rx<int> selectedSubject = 0.obs;
//
//   // Variables to store subjectId and semesterId
//   int selectedSubjectId = 0;
//   int selectedSemesterId = 0;
//
//
//   var PaperCodeName =<PaperCodeNameModel>[].obs;
//   final RxInt PaperCodeNameId=0.obs;
//
//   // RxLists to store names, semesterIds, and subjectIds
//   RxList<String> subjectNames = RxList<String>();
//   RxList<int> semesterIds = RxList<int>();
//   RxList<int> subjectIds = RxList<int>();
//   RxList<int> paperIds = RxList<int>(); // List to store paper IDs
//   RxList<String> paperNames = <String>[].obs;
//   RxInt selectedPaperCode = RxInt(0);
//
//   @override
//   void onInit() {
//     fetchDepartments();
//     fetchPaperCodeName();
//     super.onInit();
//   }
//
//   // Set the Department ID
//   void setDepartmentId(int department) {
//     departmentId.value = department;
//     print(department);
//     fetchallSubjects();
//   }
//
//   // Fetch departments from API
//   Future<void> fetchDepartments() async {
//     try {
//       var fetchedDepartments = await ApiHelper().fetchDepartments();
//       departments.assignAll(fetchedDepartments);
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to load departments');
//     }
//   }
//
//   // PaperCodeName fetch
//   Future<void> fetchPaperCodeName() async {
//
//     try{
//       var fetchPaperCodeName=await ApiHelper().fetchPaperCodeNameByAPi();
//       PaperCodeName.assignAll(fetchPaperCodeName);
//
//     }
//     catch (e){
//
//       Get.snackbar("Error", "Fetching Paper Code Name");
//     }
//   }
//
//   void setPaperCodeNameId(int paperCodeNameId) {
//     PaperCodeNameId.value = paperCodeNameId;
//   }
//
//
//   // Fetch all subjects from API
//   Future<void> fetchallSubjects() async {
//     try {
//       if (departmentId.value == null) {
//         print("department id null");
//         return;
//       }
//       String endpoint =
//           "${StudentCardApi.departmentListEndPoint}/${Subjectcardapi.subjectEndPoint}/${departmentId.value}";
//       print(endpoint);
//       var response = await ApiHelper.get(endpoint,
//           headers: await ApiHelper().getHeaders());
//       if (response.statusCode == 200) {
//         final decodedData = jsonDecode(response.body);
//         if (decodedData != null && decodedData is Map<String, dynamic>) {
//           subjectslistmodel.value = Subjectslistmodel.fromJson(decodedData);
//
//           // Clear previous data
//           subjectNames.clear();
//           semesterIds.clear();
//           subjectIds.clear();
//           paperNames.clear();
//           paperIds.clear();
//           selectedPaperCode.value = 0;
//
//           // Extract and store subjectId, semesterId, names, and paper names in variables
//           if (subjectslistmodel.value?.subjects != null) {
//             subjectslistmodel.value!.subjects!.forEach((subject) {
//               if (subject.id != null) {
//                 selectedSubjectId = subject.id!;
//                 subjectIds.add(subject.id!);
//                 print('Subject ID: ${subject.id}');
//               }
//               if (subject.semesterId != null) {
//                 selectedSemesterId = subject.semesterId!;
//                 semesterIds.add(subject.semesterId!);
//                 print('Semester ID: ${subject.semesterId}');
//               }
//               if (subject.subName != null) {
//                 subjectNames.add(subject.subName!);
//                 print('Subject Name: ${subject.subName}');
//               }
//               if (subject.paperName != null) {
//                 paperNames.add(subject.paperName!);
//                 print('Paper Name: ${subject.paperName}');
//               }
//               if (subject.paperId != null) {
//                 paperIds.add(subject.paperId!);
//                 print('Paper ID: ${subject.paperId}');
//               }
//             });
//           } else {
//             print('No subjects found');
//           }
//
//           print('Subject IDs: $subjectIds');
//           print('Semester IDs: $semesterIds');
//           print('Subject Names: $subjectNames');
//           print('Paper Names: $paperNames');
//           print('Paper IDs: $paperIds');
//         } else {
//           subjectslistmodel.value = Subjectslistmodel();
//           print(subjectslistmodel.value);
//         }
//       } else {
//         print('Error: Invalid response format - subjects key not found or not a list');
//       }
//     } catch (e) {
//       print('Error fetching subjects: $e');
//     }
//   }
//
//   // Update subject details
//   Future<void> updatedSubject() async {
//     try {
//       if (departmentId.value != null) {
//         print('subjectId: ${subjectIdController.text}');
//         print('name: ${subjectNameController.text}');
//         print('deptId: ${departmentIdController.text}');
//         print('semesterId: ${semesterIdController.text}');
//         print('subId: $selectedPaperCode');  // Use the selected paper code
//
//         if (subjectIdController.text.isEmpty) {
//           Get.snackbar('Error', 'Subject ID is null or empty');
//           return;
//         }
//
//         final body = {
//           "subjectId": int.parse(subjectIdController.text), // Include subjectId here
//           "name": subjectNameController.text,
//           "deptId": int.parse(departmentIdController.text),
//           "semesterId": int.parse(semesterIdController.text),
//           "subId": PaperCodeNameId.value,  // Pass the selected paper ID
//         };
//
//         print('Request Body: $body');
//
//         final data = await ApiHelper.update(
//           Subjectcardapi.subjectUpdateEndpoint,
//           headers: await ApiHelper().getHeaders(),
//           body: body,
//         );
//
//         print('Response Status Code: ${data.statusCode}');
//         print('Response Body: ${data.body}');
//         print('Request Body: $body');
//         if (data.statusCode == 200) {
//           Get.snackbar('Success', 'Subject updated successfully');
//
//           subjectIdController.clear();
//           subjectNameController.clear();
//           departmentIdController.clear();
//           semesterIdController.clear();
//
//           await fetchallSubjects();
//           Get.back();
//         } else {
//           Get.snackbar('Error', 'Failed to update subject');
//           print('Error: ${data.body}');
//         }
//       } else {
//         Get.snackbar('Error', 'Department ID is null');
//       }
//     } catch (e) {
//       print('Error updating subject: $e');
//       Get.snackbar('Error', 'Failed to update subject: $e');
//     }
//   }
// }

import 'dart:async';
import 'dart:convert';
import 'package:attendanceadmin/model/subjectCard/subjectsListModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../../../../../constant/AppUrl/StudentCard/StudentCardApi.dart';
import '../../../../../../constant/AppUrl/SubjectCard/SubjectCardApi.dart';
import '../../../../../../model/subjectCard/papperCodeNameModel.dart';
import '../../../../../../model/universalmodel/departmentModel.dart';
import '../../../../LoginService/AuthServices.dart';
import '../../../../LoginService/AutharizationHeader.dart';

class Updatesubjectcontroller extends GetxController {
  TextEditingController subjectIdController = TextEditingController();
  TextEditingController subjectNameController = TextEditingController();
  TextEditingController departmentIdController = TextEditingController();
  TextEditingController semesterIdController = TextEditingController();
  TextEditingController paperNameController = TextEditingController();

  final AuthService authService = AuthService();
  final RxInt departmentId = 0.obs;
  var departments = <DepartmentModel>[].obs;

  Rx<Subjectslistmodel?> subjectslistmodel = Rx<Subjectslistmodel?>(null);
  Rx<int> selectedSubject = 0.obs;

  // Variables to store subjectId and semesterId
  int selectedSubjectId = 0;
  int selectedSemesterId = 0;

  var PaperCodeName = <PaperCodeNameModel>[].obs;
  final RxInt PaperCodeNameId = 0.obs;

  // RxLists to store names, semesterIds, and subjectIds
  RxList<String> subjectNames = RxList<String>();
  RxList<int> semesterIds = RxList<int>();
  RxList<int> subjectIds = RxList<int>();
  RxList<int> paperIds = RxList<int>(); // List to store paper IDs
  RxList<String> paperNames = <String>[].obs;
  RxInt selectedPaperCode = RxInt(0);

  @override
  void onInit() {
    fetchDepartments();
    fetchPaperCodeName();
    super.onInit();
  }

  // Set the Department ID
  void setDepartmentId(int department) {
    departmentId.value = department;
    print(department);
    fetchallSubjects();
  }

  // Fetch departments from API
  Future<void> fetchDepartments() async {
    try {
      var fetchedDepartments = await ApiHelper().fetchDepartments();
      departments.assignAll(fetchedDepartments);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load departments');
    }
  }

  // PaperCodeName fetch
  Future<void> fetchPaperCodeName() async {
    try {
      var fetchPaperCodeName = await ApiHelper().fetchPaperCodeNameByAPi();
      PaperCodeName.assignAll(fetchPaperCodeName);
    } catch (e) {
      Get.snackbar("Error", "Fetching Paper Code Name");
    }
  }

  void setPaperCodeNameId(int paperCodeNameId) {
    PaperCodeNameId.value = paperCodeNameId;
  }

  // Fetch all subjects from API
  Future<void> fetchallSubjects() async {
    try {
      if (departmentId.value == null) {
        print("department id null");
        return;
      }
      String endpoint =
          "${StudentCardApi.departmentListEndPoint}/${Subjectcardapi.subjectEndPoint}/${departmentId.value}";
      print(endpoint);
      var response = await ApiHelper.get(endpoint,
          headers: await ApiHelper().getHeaders());
      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        if (decodedData != null && decodedData is Map<String, dynamic>) {
          subjectslistmodel.value = Subjectslistmodel.fromJson(decodedData);

          // Clear previous data
          subjectNames.clear();
          semesterIds.clear();
          subjectIds.clear();
          paperNames.clear();
          paperIds.clear();
          selectedPaperCode.value = 0;

          // Extract and store subjectId, semesterId, names, and paper names in variables
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
              if (subject.paperName != null) {
                paperNames.add(subject.paperName!);
                print('Paper Name: ${subject.paperName}');
              }
              if (subject.paperId != null) {
                paperIds.add(subject.paperId!);
                print('Paper ID: ${subject.paperId}');
              }
            });
          } else {
            print('No subjects found');
          }

          print('Subject IDs: $subjectIds');
          print('Semester IDs: $semesterIds');
          print('Subject Names: $subjectNames');
          print('Paper Names: $paperNames');
          print('Paper IDs: $paperIds');
        } else {
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

  // Update subject details
  Future<void> updatedSubject() async {
    try {
      if (departmentId.value != null) {
        print('subjectId: ${subjectIdController.text}');
        print('name: ${subjectNameController.text}');
        print('deptId: ${departmentIdController.text}');
        print('semesterId: ${semesterIdController.text}');
        print('subId: ${PaperCodeNameId.value}');  // Use the selected paper code

        if (subjectIdController.text.isEmpty) {
          Get.snackbar('Error', 'Subject ID is null or empty');
          return;
        }

        final body = {
          "subjectId": int.parse(subjectIdController.text), // Include subjectId here
          "name": subjectNameController.text,
          "deptId": int.parse(departmentIdController.text),
          "semesterId": int.parse(semesterIdController.text),
          "subId": PaperCodeNameId.value,  // Pass the selected paper ID
        };

        print('Request Body: $body');

        final data = await ApiHelper.update(
          Subjectcardapi.subjectUpdateEndpoint,
          headers: await ApiHelper().getHeaders(),
          body: body,
        );

        print('Response Status Code: ${data.statusCode}');
        print('Response Body: ${data.body}');
        if (data.statusCode == 200) {
          Get.snackbar('Success', 'Subject updated successfully');

          subjectIdController.clear();
          subjectNameController.clear();
          departmentIdController.clear();
          semesterIdController.clear();

          await fetchallSubjects();
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

  // Set the selected paper code automatically based on the selected subject
  void setPaperCodeAutomatically(int subjectId) {
    // Find the index of the selected subject
    int index = subjectIds.indexOf(subjectId);
    if (index != -1) {
      // Set the PaperCodeNameId based on the corresponding paperId
      PaperCodeNameId.value = paperIds[index];
      print('Automatically selected PaperCodeNameId: ${PaperCodeNameId.value}');
    }
  }
}

