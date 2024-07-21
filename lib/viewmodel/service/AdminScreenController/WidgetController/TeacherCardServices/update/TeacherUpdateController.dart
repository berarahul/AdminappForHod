import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import '../../../../../../constant/AppUrl/StudentCard/StudentCardApi.dart';
import '../../../../../../constant/AppUrl/SubjectCard/SubjectCardApi.dart';
import '../../../../../../constant/AppUrl/TeacherCard/TeacherCardAPi.dart';
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

  var subjects = <SubjectModel>[].obs;

  var selectedRemoveSubjects=<SubjectModel>[].obs;

  var subjects2=<SubjectModel>[].obs;

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
      var fetchsubjects = await SecondTimefetchSubjects();
      subjects.assignAll(fetchsubjects);
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




  Future<List<SubjectModel>> SecondTimefetchSubjects() async {
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

  FutureOr<void> updatedTeacher() async {
    if (departmentId.value != null) {
      final data = await ApiHelper.update(
        Teachercardapi.updateTeacherEndPoint,
        headers: await ApiHelper().getHeaders(),
        body: {
          "teacherId": int.parse(teacherIdController.text),
          "name": nameController.text,
          "newSubjectIds": selectedSubjects.map((subject) => subject.id).toList(),
          "removeSubjectIds":selectedSubjects.map((subject) => subject.id).toList(),
        },
      );

      if (data.statusCode == 200) {
        Get.snackbar('Success', 'Teacher updated successfully');

        nameController.clear();
        teacherIdController.clear();
        teacherList.clear();
        teacherId.clear();

        await fetchAllTeacher();
        Get.back();
      } else {
        Get.snackbar('Error', 'Failed to update Teacher');
        print('Failed to update Teacher. Response: ${data.body}');
      }
    }
  }
  void clearSelectedSubjects(){
    selectedSubjects.clear();
  }

  void clearselectedRemoveSubjects(){
    selectedRemoveSubjects.clear();
  }
}