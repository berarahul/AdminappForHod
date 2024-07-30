import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../../../../../../constant/AppUrl/StudentCard/StudentCardApi.dart';
import '../../../../../../constant/AppUrl/SubjectCard/SubjectCardApi.dart';
import '../../../../../../constant/AppUrl/TeacherCard/TeacherCardAPi.dart';
import '../../../../../../model/TeacherWiseSubjectModel/teacherWiseSubjectModel.dart';
import '../../../../../../model/login/LoginModel.dart';
import '../../../../../../model/subjectCard/subjectsListModel.dart';
import '../../../../../../model/universalmodel/departmentModel.dart';
import '../../../../LoginService/AuthServices.dart';
import '../../../../LoginService/AutharizationHeader.dart';

class UpdateTeacherController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController teacherIdController = TextEditingController();

  final AuthService authService = AuthService();
  RxList<String> teacherList = <String>[].obs;
  RxList<int> teacherId = <int>[].obs;

  final RxInt departmentId = 0.obs;
  var departments = <DepartmentModel>[].obs;
  var selectedSubjects = <SubjectModel>[].obs;
  var selectedRemoveSubjects = <TeacherwiseSubjectModel>[].obs;

  var subjects = <SubjectModel>[].obs;
  var subjects2 = <TeacherwiseSubjectModel>[].obs;
  final GetStorage storage = GetStorage();
  @override
  void onInit() {
    getDepartmentId();
    fetchDepartments();
    super.onInit();
  }

  void setDepartmentId(int department) {
    departmentId.value = department;
    print("Department ID set to: $department");
  }

  Future<void> fetchDepartments() async {
    try {
      var fetchedDepartments = await ApiHelper().fetchDepartments();
      departments.assignAll(fetchedDepartments);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load departments');
    }
  }

  Future<void> fetchsubjects() async {
    try {
      var fetchsubjects = await fetchSubjects();
      subjects.assignAll(fetchsubjects);
    } catch (e) {
      print("Error fetching subjects: $e");
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> secondtimefetchsubjects() async {
    try {
      var fetchsubjects = await FetchSubjectforRemove();
      subjects2.assignAll(fetchsubjects as Iterable<TeacherwiseSubjectModel>);
    } catch (e) {
      print("Error fetching subjects: $e");
      Get.snackbar('Error', e.toString());
    }
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
      }
    }
  }

  Future<List<SubjectModel>> fetchSubjects() async {
    try {
      final headers = await ApiHelper().getHeaders();
      print('Department ID set to: $departmentId');

      final url = "https://attendancesystem-s1.onrender.com/api/${StudentCardApi.departmentListEndPoint}/${Subjectcardapi.subjectEndPoint}/$departmentId";
      print('Fetching subjects from URL: $url with headers: $headers');

      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = jsonDecode(response.body);
        print('Response data: $jsonData');

        List<dynamic> subjectsList = jsonData['subjects'];
        if (subjectsList == null) {
          throw Exception('Subjects list is null');
        }

        return subjectsList.map((item) => SubjectModel.fromJson(item)).toList();
      } else {
        print('Failed to load subjects: ${response.body}');
        throw Exception('Failed to load subjects: ${response.body}');
      }
    } catch (e) {
      print('Error fetching subjects: $e');
      throw Exception('Error fetching subjects: $e');
    }
  }

  Future<List<TeacherwiseSubjectModel>> FetchSubjectforRemove() async {
    try {
      final headers = await ApiHelper().getHeaders();
      print('Department ID set to: $departmentId');
      int? selectedteacherid = retrieveSelectedTeacherId();
      final url = "https://attendancesystem-s1.onrender.com/api/teacher/$selectedteacherid/$departmentId";
      print('Fetching subjects from URL: $url with headers: $headers');

      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        // Assuming the response is a list of subjects, not a map
        List<dynamic> jsonData = jsonDecode(response.body);
        print('Response data: $jsonData');

        // Ensure that jsonData is a list and map each item to TeacherwiseSubjectModel
        return jsonData.map((item) => TeacherwiseSubjectModel.fromJson(item)).toList();
      } else {
        print('Failed to load subjects: ${response.body}');
        throw Exception('Failed to load subjects: ${response.body}');
      }
    } catch (e) {
      print('Error fetching subjects: $e');
      throw Exception('Error fetching subjects: $e');
    }
  }


  FutureOr<void> fetchAllTeacher() async {
    if (teacherList.isNotEmpty) {
      teacherList.clear();
    } else {
      if (departmentId.value != null) {
        await ApiHelper.get(
          "${Teachercardapi.allTeachersEndpoint}$departmentId",
          headers: await ApiHelper().getHeaders(),
        ).then((value) {
          final List<dynamic> bodyDecode = jsonDecode(value.body);

          for (var teacher in bodyDecode) {
            teacherList.add(teacher['name']);
            teacherId.add(teacher['teacherId']);
          }
        });
      } else {
        Get.snackbar('Error', 'Please select department');
      }
    }
  }



  FutureOr<void> updateTeacherWithSubjects() async {
    if (departmentId.value != null) {
      final requestBody = {
        "teacherId": int.parse(teacherIdController.text),
        "name": nameController.text,
        "newSubjectIds": selectedSubjects.map((subject) => subject.id).toList(),
      };

      print('Request Body: $requestBody');

      final data = await ApiHelper.update(
        Teachercardapi.updateTeacherEndPoint,
        headers: await ApiHelper().getHeaders(),
        body: requestBody,
      );

      if (data.statusCode == 200) {

        _clearAllFields();
      } else {
        Get.snackbar('Error', 'Failed to update Teacher');
        print('Failed to update Teacher. Response: ${data.body}');
      }
    }
  }




  FutureOr<void> updateTeacherWithoutSubjects() async {
    if (departmentId.value != null) {
      String teacherIdText = teacherIdController.text;

      // Check if teacherIdText is not empty and can be parsed to an integer
      if (teacherIdText.isEmpty) {
        Get.snackbar('Error', 'Teacher ID cannot be empty');
        return;
      }

      int teacherId;
      try {
        teacherId = int.parse(teacherIdText);
      } catch (e) {
        Get.snackbar('Error', 'Invalid Teacher ID');
        print('Error parsing Teacher ID: $e');
        return;
      }

      final requestBody = {
        "teacherId": teacherId,
        "name": nameController.text,
        "removeSubjectIds": selectedRemoveSubjects.map((subject) => subject.subjectId).toList(),
      };

      print('Request Body: $requestBody');

      // Define the URL for updating the teacher
      final url = "https://attendancesystem-s1.onrender.com/api/hod/teacher/updateTeacher"; // Replace with your actual endpoint

      try {
        // Perform the PUT request
        final response = await http.put(
          Uri.parse(url),
          headers: await ApiHelper().getHeaders(),
          body: jsonEncode(requestBody),
        );

        if (response.statusCode == 200) {
          Get.snackbar("Success", "Subject Removed Successfully");
          _clearAllFields();
        } else {
          Get.snackbar('Error', 'Failed to update Teacher');
          print('Failed to update Teacher. Response: ${response.body}');
        }
      } catch (e) {
        Get.snackbar('Error', 'An error occurred: $e');
        print('Error: $e');
      }
    }
  }



  Future<void> updateTeacherNameOnly() async {
    final requestBody = {
      "teacherId": int.parse(teacherIdController.text),
      "name": nameController.text,
    };

    print('Request Body for Name Update: $requestBody');

    final response = await http.put(
      Uri.parse('https://attendancesystem-s1.onrender.com/api/hod/teacher/updateTeacher'), // Replace with your actual endpoint
      headers: await ApiHelper().getHeaders(),
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      Get.snackbar("Success", "Teacher Name Updated Successfully");
      _clearAllFields();
    } else {
      Get.snackbar('Error', 'Failed to update Teacher Name');
      print('Failed to update Teacher Name. Response: ${response.body}');
    }
  }



  void _clearAllFields() {
    nameController.clear();
    teacherIdController.clear();
    teacherList.clear();
    teacherId.clear();
    selectedSubjects.clear();
    selectedRemoveSubjects.clear();
    fetchAllTeacher();
    Get.back();
  }

  void clearSelectedSubjects() {
    print(selectedSubjects);
    selectedSubjects.clear();
    print(selectedSubjects);
  }

  void clearSelectedRemoveSubjects() {
    print(selectedRemoveSubjects);
    selectedRemoveSubjects.clear();
    print(selectedRemoveSubjects);
  }
  void storeSelectedTeacherId(int id) {
    storage.write('selectedTeacherId', id);
    print("Selected Teacher ID stored: $id");
  }

  int? retrieveSelectedTeacherId() {
    return storage.read('selectedTeacherId');
  }
}
