import 'dart:async';
import 'dart:convert';

import 'package:attendanceadmin/constant/AppUrl/StudentCard/StudentCardApi.dart';
import 'package:attendanceadmin/constant/AppUrl/SubjectCard/SubjectCardApi.dart';
import 'package:attendanceadmin/constant/AppUrl/TeacherCard/TeacherCardAPi.dart';
import 'package:attendanceadmin/model/LoginModel.dart';
import 'package:attendanceadmin/viewmodel/service/LoginService/AuthServices.dart';
import 'package:attendanceadmin/viewmodel/service/LoginService/AutharizationHeader.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get_storage/get_storage.dart';

// Controller class for removing students, utilizing GetX for state management.
class RemoveSubjectController extends GetxController {
  // Instance of the authentication service.
  final AuthService authService = AuthService();

  // Observable list of department IDs. Initially null.
  RxList departmentIdList = [].obs;
  // Observable list of semesters.
  RxList<int> semesters = [1, 2, 3, 4, 5, 6].obs;

  // Observable list of roll numbers. Initially empty.

  // Observable for tracking the selected department ID. Initially null.
  Rx<int?> selectedDepartmentId = Rx<int?>(null);
  // Observable for tracking the selected semester. Initially null.
  Rx<int?> selectedSemester = Rx<int?>(null);
  // Observable list of all students. Initially empty.
  RxList subjects = [].obs;
  // Observable list of student roll numbers. Initially empty.
  RxList<int> subjectId = <int>[].obs;
  // Observable list of students filtered by search query. Initially empty.
  RxList filteredSubjects = [].obs;
  // Observable list of selected students for removal. Initially empty.
  RxList selectedSubjects = [].obs;


  RxList<String> subjectsList = <String>[].obs;
  RxList<int> selectedSubjectIds = <int>[].obs;


  void toggleIsUserSelected({required int index}) {
    var subject = subjects[index];
    if (selectedSubjects.contains(subject)) {
      selectedSubjects.remove(subject);
    } else {
      selectedSubjects.add(subject);
    }
  }

  // Fetches students from a simulated API based on the selected semester.
  void fetchStudents(int semester) {
    // Simulates a delay to mimic an asynchronous API call.
    Future.delayed(const Duration(seconds: 1), () {
      // Simulated data for demonstration. Replace with actual API call.
      if (semester == 0) {
        subjects.clear();
      } else if (semester == 1) {
        subjects.clear();

        fetchallSubjects();
      } else if (semester == 2) {
        subjects.clear();

        //
        fetchallSubjects();
      } else if (semester == 3) {
        subjects.clear();

        //
        fetchallSubjects();
      } else if (semester == 4) {
        subjects.clear();
      } else if (semester == 5) {
        subjects.clear();
      } else if (semester == 6) {
        subjects.clear();
        fetchallSubjects();
      }
      // Initially, all fetched students are considered as filtered.
      filteredSubjects.assignAll(subjects);
    });
  }

  // Filters the student list based on a search query.
  void filterSearchResults(String query) {
    // If query is empty, all students are shown.
    if (query.isEmpty) {
      filteredSubjects.assignAll(subjects);
    } else {
      // Converts query to lowercase for case-insensitive search.
      final lowercaseQuery = query.toLowerCase();
      // Filters students based on the query.
      filteredSubjects.assignAll(subjects
          .where((student) => student.toLowerCase().contains(lowercaseQuery)));
    }
  }

  // Selects or deselects all students based on the given boolean value.
  void selectAllStudents(bool selectAll) {
    if (selectAll) {
      // Selects all students if true.
      selectedSubjects.assignAll(filteredSubjects);
    } else {
      // Clears selection if false.
      selectedSubjects.clear();
    }
  }

  // Adds or removes a student from the selected list based on a boolean value.
  void addOrRemoveStudent(String student, bool selected) {
    if (selected) {
      // Adds the student to the selected list if not already present.
      if (!selectedSubjects.contains(student)) {
        selectedSubjects.add(student);
      }
    } else {
      // Removes the student from the selected list.
      selectedSubjects.remove(student);
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
  }
  //
  // FutureOr<void> fetchAllStudent() async {
  //   if (selectedSemester.value != null) {
  //     await ApiHelper.get(
  //       "${Subjectcardapi.subjectViewEndpoint}/$selectedDepartmentId",
  //       headers: await ApiHelper().getHeaders(),
  //     ).then((value) {
  //       final List<dynamic> bodyDecode = jsonDecode(value.body);
  //
  //       for (var student in bodyDecode) {
  //         students.add(student['name']);
  //
  //         studentRollNumber.add(student['roll']);
  //       }
  //     });
  //   } else {
  //     Get.snackbar(
  //       "Error",
  //       "please select the semester",
  //     );
  //   }
  // }



  Future<void> fetchallSubjects() async {
    try {
      if (selectedDepartmentId.value == null) {
        print('Error: Selected department ID is null');
        return;
      }

      String endpoint =
          "${StudentCardApi.departmentListEndPoint}/${Subjectcardapi.subjectEndPoint}/${selectedDepartmentId.value}";

      var response = await ApiHelper.get(endpoint,
          headers: await ApiHelper().getHeaders());

      if (response.statusCode == 200) {
        Map<String, dynamic> decodedData = jsonDecode(response.body);

        if (decodedData.containsKey('subjects') &&
            decodedData['subjects'] is List) {
          List<dynamic> subjectsListResponse = decodedData['subjects'];

          subjectsList.clear();

          for (var subject in subjectsListResponse) {
            String subjectId =
            subject['subjectId'].toString(); // Assuming subjectId is an int
            subjectsList.add(subjectId);
          }
        } else {
          print(
              'Error: Invalid response format - subjects key not found or not a list');
        }
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching subjects: $e');
    }
  }




  // Removes the selected students. Placeholder for actual removal logic.
  Future<void> removeSelectedSubjects() async {
    // Store data of user model in a variable which can be null.
    final UserModel? userModel = authService.getUserModel();

    // If userModel is not null, proceed with removal logic.
    if (userModel != null) {
      // Print the user model data.
      await ApiHelper.delete(StudentCardApi.removeStudentEndPoint,
          headers: await ApiHelper().getHeaders(),
          body: {
            // "semester": selectedSemester.value,
            // "deptId": selectedDepartmentId.value,
            // "rolls": studentRollNumber,

            "departmentName": selectedDepartmentId.value,
            "subjectId": selectedSubjects.value,
            "semester": selectedSemester.value,

          });

      //Show a snackbar message to indicate successful removal.
      Get.snackbar(
        "Success",
        "Selected students have been removed",
      );
    } else {
      // Print an error message if userModel is null.
      Get.snackbar(
        "Something Went Wrong",
        "please log-out and log-in again",
      );
    }
  }

  Future<void> updateList() async {
    subjects.clear();
    selectedSubjects.clear();
    await fetchallSubjects();
  }

  @override
  void onInit() {
    super.onInit();
    getDepartmentId();
  }

  // Called when the controller is being disposed.
  @override
  void onClose() {
    super.onClose();
    // Ensures selected students are removed when the controller is disposed.
    removeSelectedSubjects();
  }
}
