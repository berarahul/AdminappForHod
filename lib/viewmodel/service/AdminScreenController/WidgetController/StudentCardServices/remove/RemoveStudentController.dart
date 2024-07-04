import 'dart:async';
import 'dart:convert';

import 'package:attendanceadmin/constant/AppUrl/StudentCard/StudentCardApi.dart';
import 'package:attendanceadmin/constant/AppUrl/TeacherCard/TeacherCardAPi.dart';
import 'package:attendanceadmin/model/LoginModel.dart';
import 'package:attendanceadmin/viewmodel/service/LoginService/AuthServices.dart';
import 'package:attendanceadmin/viewmodel/service/LoginService/AutharizationHeader.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

// Controller class for removing students, utilizing GetX for state management.
class RemoveStudentController extends GetxController {
  // Instance of the authentication service.
  final AuthService authService = AuthService();

  // Observable list of department IDs. Initially null.
  RxList departmentIdList = [].obs;
  // Observable list of semesters.
  RxList<int> semesters = [1, 2, 3, 4, 5, 6].obs;

  // Observable list of roll numbers. Initially empty.
  RxList<int> rollNumList = <int>[].obs;
  // Observable for tracking the selected department ID. Initially null.
  Rx<int?> selectedDepartmentId = Rx<int?>(null);
  // Observable for tracking the selected semester. Initially null.
  Rx<int?> selectedSemester = Rx<int?>(null);
  // Observable list of all students. Initially empty.
  RxList students = [].obs;
  // Observable list of student roll numbers. Initially empty.
  RxList<int> studentRollNumber = <int>[].obs;
  // Observable list of students filtered by search query. Initially empty.
  RxList filteredStudents = [].obs;
  // Observable list of selected students for removal. Initially empty.
  RxList selectedStudents = [].obs;

  void toggleIsUserSelected({required int index}) {
    var student = students[index];
    if (selectedStudents.contains(student)) {
      selectedStudents.remove(student);
    } else {
      selectedStudents.add(student);
    }
  }

  // Fetches students from a simulated API based on the selected semester.
  void fetchStudents(int semester) {
    // Simulates a delay to mimic an asynchronous API call.
    Future.delayed(const Duration(seconds: 1), () {
      // Simulated data for demonstration. Replace with actual API call.
      if (semester == 0) {
        students.clear();
      } else if (semester == 1) {
        students.clear();

        fetchAllStudent();
      } else if (semester == 2) {
        students.clear();

        //
        fetchAllStudent();
      } else if (semester == 3) {
        students.clear();

        //
        fetchAllStudent();
      } else if (semester == 4) {
        students.clear();
      } else if (semester == 5) {
        students.clear();
      } else if (semester == 6) {
        students.clear();
        fetchAllStudent();
      }
      // Initially, all fetched students are considered as filtered.
      filteredStudents.assignAll(students);
    });
  }

  // Filters the student list based on a search query.
  void filterSearchResults(String query) {
    // If query is empty, all students are shown.
    if (query.isEmpty) {
      filteredStudents.assignAll(students);
    } else {
      // Converts query to lowercase for case-insensitive search.
      final lowercaseQuery = query.toLowerCase();
      // Filters students based on the query.
      filteredStudents.assignAll(students
          .where((student) => student.toLowerCase().contains(lowercaseQuery)));
    }
  }

  // Selects or deselects all students based on the given boolean value.
  void selectAllStudents(bool selectAll) {
    if (selectAll) {
      // Selects all students if true.
      selectedStudents.assignAll(filteredStudents);
    } else {
      // Clears selection if false.
      selectedStudents.clear();
    }
  }

  // Adds or removes a student from the selected list based on a boolean value.
  void addOrRemoveStudent(String student, bool selected) {
    if (selected) {
      // Adds the student to the selected list if not already present.
      if (!selectedStudents.contains(student)) {
        selectedStudents.add(student);
      }
    } else {
      // Removes the student from the selected list.
      selectedStudents.remove(student);
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

  FutureOr<void> fetchAllStudent() async {
    if (selectedSemester.value != null) {
      await ApiHelper.get(
        "${StudentCardApi.studentListEndPoint}/$selectedDepartmentId/$selectedSemester",
        headers: await ApiHelper().getHeaders(),
      ).then((value) {
        final List<dynamic> bodyDecode = jsonDecode(value.body);

        for (var student in bodyDecode) {
          students.add(student['name']);

          studentRollNumber.add(student['roll']);
        }
      });
    } else {
      Get.snackbar(
        "Error",
        "please select the semester",
      );
    }
  }

  // Removes the selected students. Placeholder for actual removal logic.
  Future<void> removeSelectedStudents() async {
    // Store data of user model in a variable which can be null.
    final UserModel? userModel = authService.getUserModel();

    // If userModel is not null, proceed with removal logic.
    if (userModel != null) {
      // Print the user model data.
      await ApiHelper.delete(StudentCardApi.removeStudentEndPoint,
          headers: await ApiHelper().getHeaders(),
          body: {
            "semester": selectedSemester.value,
            "deptId": selectedDepartmentId.value,
            "rolls": studentRollNumber,
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
    students.clear();
    selectedStudents.clear();
    await fetchAllStudent();
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
    removeSelectedStudents();
  }
}
