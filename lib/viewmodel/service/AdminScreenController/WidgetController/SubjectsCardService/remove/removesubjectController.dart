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

import '../../../../../../model/subjectsListModel.dart';

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

  Rx<int> selectedSubject = 0.obs;

  Rx<Subjectslistmodel?> subjectslistmodel = Subjectslistmodel().obs;

  void toggleIsUserSelected({required int index}) {}

  // Fetches students from a simulated API based on the selected semester.
  void fetchStudents(int semester) {
    // Simulates a delay to mimic an asynchronous API call.
    Future.delayed(const Duration(seconds: 1), () {
      // Simulated data for demonstration. Replace with actual API call.
      if (semester == 0) {
      } else if (semester == 1) {
        fetchallSubjects();
      } else if (semester == 2) {
        fetchallSubjects();
      } else if (semester == 3) {
        fetchallSubjects();
      } else if (semester == 4) {
        fetchallSubjects();
      } else if (semester == 5) {
        fetchallSubjects();
      } else if (semester == 6) {
        fetchallSubjects();
      }
    });
  }

  // Adds or removes a student from the selected list based on a boolean value.
  void addOrRemoveStudent({required int index}) {
    // If the student is already selected, remove them.
    if (selectedSubject.value ==
        subjectslistmodel.value!.subjects![index].subjectId!) {
      selectedSubject.value = 0;
    }
    // Otherwise, add them to the selected list.
    else {
      selectedSubject.value =
          subjectslistmodel.value!.subjects![index].subjectId!;
    }

    print('Selected Subject: ${selectedSubject.value}');
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

  Future<void> fetchallSubjects() async {
    try {
      if (selectedDepartmentId.value == null) {
        return;
      }
      String endpoint =
          "${StudentCardApi.departmentListEndPoint}/${Subjectcardapi.subjectEndPoint}/${selectedDepartmentId.value}";
      var response = await ApiHelper.get(endpoint,
          headers: await ApiHelper().getHeaders());
      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        // Check if decodedData is not null and properly formatted before assigning
        if (decodedData != null && decodedData is Map<String, dynamic>) {
          subjectslistmodel.value = Subjectslistmodel.fromJson(decodedData);
        } else {
          // Assign a default value or handle the null case
          subjectslistmodel.value = Subjectslistmodel();
        }
      } else {
        print(
            'Error: Invalid response format - subjects key not found or not a list');
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
      final resposne = await ApiHelper.delete(
        "${Subjectcardapi.subjectDeleteEndpoint}?deptId=${selectedDepartmentId.value}&subjectId=${selectedSubject.value}",
        headers: await ApiHelper().getHeaders(),
      );

      print(
          "final url: ${Subjectcardapi.subjectDeleteEndpoint}?deptId=${selectedDepartmentId.value}&subjectId=${selectedSubject.value}");

      if (resposne.statusCode == 200) {
        Get.snackbar(
          "Success",
          "Subject Removed Successfully",
        );

        // clear the model
        subjectslistmodel.value = Subjectslistmodel();

        // Clear the selected students list.
        selectedSubject.value = 0;

        // Update the list of students.
        await fetchallSubjects();
      } else {
        Get.snackbar(
          "Error",
          "Failed to remove subject",
        );

        // Print an error message if the response code is not 200.
        print('Error: Failed to remove subject - ${resposne.statusCode}');

        print('Error: Failed to remove subject - ${resposne.body}');

        print(
            "final url: ${Subjectcardapi.subjectDeleteEndpoint}?deptId=${selectedDepartmentId.value}&subjectId=${selectedSubject.value}");
      }
    } else {
      // Print an error message if userModel is null.
      Get.snackbar(
        "Something Went Wrong",
        "please log-out and log-in again",
      );
    }
  }

  Future<void> updateList() async {
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
