// import 'dart:async';
// import 'dart:convert';
//
// import 'package:attendanceadmin/constant/AppUrl/StudentCard/StudentCardApi.dart';
// import 'package:attendanceadmin/constant/AppUrl/TeacherCard/TeacherCardAPi.dart';
// import 'package:attendanceadmin/model/LoginModel.dart';
// import 'package:attendanceadmin/viewmodel/service/LoginService/AuthServices.dart';
// import 'package:attendanceadmin/viewmodel/service/LoginService/AutharizationHeader.dart';
// import 'package:get/get.dart';
// import 'package:get/get_rx/get_rx.dart';
//
// import '../../../../../../model/departmentModel.dart';
//
// class RemoveStudentController extends GetxController {
//   final AuthService authService = AuthService();
//
//
//   RxList<int> semesters = [1, 2, 3, 4, 5, 6].obs;
//
//   RxList<int> rollNumList = <int>[].obs;
//
//   Rx<int?> selectedSemester = Rx<int?>(null);
//
//   RxList students = [].obs;
//
//   RxList<int> studentRollNumber = <int>[].obs;
//
//   RxList filteredStudents = [].obs;
//
//   RxList selectedStudents = [].obs;
//
//   var departments = <DepartmentModel>[].obs;
//
//   final RxInt departmentId = 0.obs;
//
//
//
//
//
//
//   void toggleIsUserSelected({required int index}) {
//     var student = students[index];
//     if (selectedStudents.contains(student)) {
//       selectedStudents.remove(student);
//     } else {
//       selectedStudents.add(student);
//     }
//   }
//
//
//
//
//
//   void setDepartmentId(int department) {
//     departmentId.value = department;
//   }
//
//
//
//
//   // Fetches students from a simulated API based on the selected semester.
//   void fetchStudents(int semester) {
//     // Simulates a delay to mimic an asynchronous API call.
//     Future.delayed(const Duration(seconds: 1), () {
//       // Simulated data for demonstration. Replace with actual API call.
//       if (semester == 0) {
//         students.clear();
//       } else if (semester == 1) {
//         students.clear();
//
//         fetchAllStudent();
//       } else if (semester == 2) {
//         students.clear();
//
//         //
//         fetchAllStudent();
//       } else if (semester == 3) {
//         students.clear();
//
//         //
//         fetchAllStudent();
//       } else if (semester == 4) {
//         students.clear();
//
//         fetchAllStudent();
//       } else if (semester == 5) {
//         students.clear();
//         fetchAllStudent();
//       } else if (semester == 6) {
//         students.clear();
//         fetchAllStudent();
//       }
//       // Initially, all fetched students are considered as filtered.
//       filteredStudents.assignAll(students);
//     });
//   }
//
//
//
//
//   // Filters the student list based on a search query.
//   void filterSearchResults(String query) {
//     // If query is empty, all students are shown.
//     if (query.isEmpty) {
//       filteredStudents.assignAll(students);
//     } else {
//       // Converts query to lowercase for case-insensitive search.
//       final lowercaseQuery = query.toLowerCase();
//       // Filters students based on the query.
//       filteredStudents.assignAll(students
//           .where((student) => student.toLowerCase().contains(lowercaseQuery)));
//     }
//   }
//
//
//
//   // Selects or deselects all students based on the given boolean value.
//   void selectAllStudents(bool selectAll) {
//     if (selectAll) {
//       // Selects all students if true.
//       selectedStudents.assignAll(filteredStudents);
//     } else {
//       // Clears selection if false.
//       selectedStudents.clear();
//     }
//   }
//
//
//
//   // Adds or removes a student from the selected list based on a boolean value.
//   void addOrRemoveStudent(String student, bool selected) {
//     if (selected) {
//       // Adds the student to the selected list if not already present.
//       if (!selectedStudents.contains(student)) {
//         selectedStudents.add(student);
//       }
//     } else {
//       // Removes the student from the selected list.
//       selectedStudents.remove(student);
//     }
//   }
//
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
//   }
//
//
//   Future<void> fetchAllStudent() async {
//     if (selectedSemester.value != null) {
//       try {
//         final response = await ApiHelper.get(
//           "${StudentCardApi.studentListEndPoint}/$departmentId/$selectedSemester",
//           headers: await ApiHelper().getHeaders(),
//         );
//
//         if (response.statusCode == 200) {
//           final List<dynamic> bodyDecode = jsonDecode(response.body);
//
//           // Clear existing data before adding new data
//           students.clear();
//           studentRollNumber.clear();
//
//           // Assuming each student entry in bodyDecode is a Map
//           for (var student in bodyDecode) {
//             students.add(student['name']);
//             studentRollNumber.add(student['roll']);
//           }
//         } else {
//           // Handle non-200 status code
//           throw Exception('Failed to fetch students: ${response.statusCode}');
//         }
//       } catch (e) {
//         // Handle any exceptions that occur during the API call or data processing
//         print('Error fetching students: $e');
//         Get.snackbar('Error', 'Failed to fetch students');
//       }
//     } else {
//       Get.snackbar(
//         "Error",
//         "Please select the semester",
//       );
//     }
//   }
//
//
//   // Removes the selected students. Placeholder for actual removal logic.
//   Future<void> removeSelectedStudents() async {
//     // Store data of user model in a variable which can be null.
//     final UserModel? userModel = authService.getUserModel();
//
//     // If userModel is not null, proceed with removal logic.
//     if (userModel != null) {
//       // Print the user model data.
//       await ApiHelper.delete(StudentCardApi.removeStudentEndPoint,
//           headers: await ApiHelper().getHeaders(),
//           body: {
//             "semester": selectedSemester.value,
//             "deptId": departmentId.value,
//             "rolls": studentRollNumber.toList(),
//           });
//
//       //Show a snackbar message to indicate successful removal.
//       Get.snackbar(
//         "Success",
//         "Selected students have been removed",
//       );
//
//     } else {
//       // Print an error message if userModel is null.
//       Get.snackbar(
//         "Something Went Wrong",
//         "please log-out and log-in again",
//       );
//     }
//   }
//
//
//
//   Future<void> fetchDepartments() async {
//     try {
//       var fetchedDepartments = await ApiHelper().fetchDepartments();
//       departments.assignAll(fetchedDepartments);
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to load departments');
//     }
//   }
//   Future<void> updateList() async {
//     students.clear();
//     selectedStudents.clear();
//     await fetchAllStudent();
//   }
//
//
//
//   @override
//   void onInit() {
//     super.onInit();
//     getDepartmentId();
//     fetchDepartments();
//   }
//
//
//   // Called when the controller is being disposed.
//   @override
//   void onClose() {
//     super.onClose();
//     // Ensures selected students are removed when the controller is disposed.
//     removeSelectedStudents();
//   }
// }

import 'dart:async';
import 'dart:convert';

import 'package:attendanceadmin/constant/AppUrl/StudentCard/StudentCardApi.dart';
import 'package:attendanceadmin/constant/AppUrl/TeacherCard/TeacherCardAPi.dart';
import 'package:attendanceadmin/model/LoginModel.dart';
import 'package:attendanceadmin/viewmodel/service/LoginService/AuthServices.dart';
import 'package:attendanceadmin/viewmodel/service/LoginService/AutharizationHeader.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

import '../../../../../../model/departmentModel.dart';

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
