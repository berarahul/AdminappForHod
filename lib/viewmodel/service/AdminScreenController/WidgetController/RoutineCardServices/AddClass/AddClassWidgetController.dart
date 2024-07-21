import 'dart:async';
import 'dart:convert';

import 'package:attendanceadmin/constant/AppUrl/api_const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../../../../../constant/AppUrl/RoutineCard/RoutineCardApi.dart';
import '../../../../../../constant/AppUrl/StudentCard/StudentCardApi.dart';
import '../../../../../../constant/AppUrl/SubjectCard/SubjectCardApi.dart';
import '../../../../../../constant/AppUrl/TeacherCard/TeacherCardAPi.dart';
import '../../../../../../model/RoutineModel/RoutineModel.dart';
import '../../../../../../model/login/LoginModel.dart';
import '../../../../../../model/subjectCard/subjectsListModel.dart';
import '../../../../../../model/universalmodel/departmentModel.dart';
import '../../../../LoginService/AuthServices.dart';
import '../../../../LoginService/AutharizationHeader.dart';
// Adjust this import statement to match your project structure

class AddClassController extends GetxController {
  final formKey = GlobalKey<FormBuilderState>();
  final AuthService authService = AuthService();
  // Fields for the form
  var teacherId = 0.obs; // Add this
  var subjectId = 0.obs;
  var startTime = TimeOfDay.now().obs;
  var endTime = TimeOfDay.now().obs;
  var roomName = ''.obs;
  final RxInt departmentId = 0.obs;
  var departments = <DepartmentModel>[].obs;
  var subjects = <SubjectModel>[].obs;
  var teachers = <TeacherModel>[].obs;
  var day = 'MONDAY'.obs; // Default value set to Monday

  // Day

  List<String> daysOfWeek = [
    'MONDAY',
  'TUESDAY',
    'WEDNESDAY',
    'THURSDAY',
    'FRIDAY',
    'SATURDAY',
  ];

  @override
  void onInit() {
    getDepartmentId();
    fetchDepartments();
    super.onInit();
  }

  // Get Department ID
  Future<void> getDepartmentId() async {
    final UserModel? userModel = authService.getUserModel();
    if (userModel != null) {
      final response = await ApiHelper.get(
        "${Teachercardapi.teacherEndPoint}/${userModel.id}",
        headers: await ApiHelper().getHeaders(),
      );

      if (response.statusCode == 200) {
        final List<dynamic> bodyDecode = jsonDecode(response.body);
        // Additional processing if needed
      }
    }
  }


  // Fetch Teachers
  Future<void> fetchTeachers() async {
    try {
      final headers = await ApiHelper().getHeaders();
      final url = "https://attendancesystem-s1.onrender.com/api/${Teachercardapi.allTeachersEndpoint}${departmentId.value}";

      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final List<dynamic> teachersList = jsonData ?? [];

        teachers.assignAll(teachersList.map((item) => TeacherModel.fromJson(item)).toList());
        print("Teachers fetched and assigned: $teachers");
      } else {
        print('Failed to load teachers: ${response.body}');
        Get.snackbar('Error', 'Failed to load teachers');
      }
    } catch (e) {
      print('Error fetching teachers: $e');
      Get.snackbar('Error', 'Error fetching teachers: $e');
    }
  }




  // Fetch Subjects
  Future<void> fetchSubjects() async {
    try {
      final headers = await ApiHelper().getHeaders();
      final url = "https://attendancesystem-s1.onrender.com/api/${StudentCardApi.departmentListEndPoint}/${Subjectcardapi.subjectEndPoint}/${departmentId.value}";

      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final List<dynamic> subjectsList = jsonData['subjects'] ?? [];

        subjects.assignAll(subjectsList.map((item) => SubjectModel.fromJson(item)).toList());
        print("Subjects fetched and assigned: $subjects");
      } else {
        print('Failed to load subjects: ${response.body}');
        Get.snackbar('Error', 'Failed to load subjects');
      }
    } catch (e) {
      print('Error fetching subjects: $e');
      Get.snackbar('Error', 'Error fetching subjects: $e');
    }
  }

  // Fetch Departments
  Future<void> fetchDepartments() async {
    try {
      final fetchedDepartments = await ApiHelper().fetchDepartments();
      departments.assignAll(fetchedDepartments);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load departments');
    }
  }


  void clearSelections(){
    startTime.value = TimeOfDay.now();
    endTime.value = TimeOfDay.now();
    roomName.value = '';
    teacherId.value = 0;
    subjectId.value = 0;
    departmentId.value = 0;
    day.value = 'MONDAY';
  }
  // Set Department ID
  void setDepartmentId(int department) {
    departmentId.value = department;
    print("Department ID set to: $department");
    // fetchSubjects(); // Fetch subjects when department is set
  }

  // Set Subject ID
  void setSubjectId(int subject) {
    subjectId.value = subject;
    print("Subject ID set to: $subject");
  }


  void setTeacherId(int teacher){
    teacherId.value = teacher;
    print("Selected Teacher ID: $teacherId");
  }

  // Handle form submission
  Future<void> submit() async {
    if (formKey.currentState?.saveAndValidate() ?? false) {
      final String formattedStartTime = DateFormat('HH:mm:ss').format(
        DateTime(0, 1, 1, startTime.value.hour, startTime.value.minute),
      );

      final String formattedEndTime = DateFormat('HH:mm:ss').format(
        DateTime(0, 1, 1, endTime.value.hour, endTime.value.minute),
      );
      final data = {
        // 'departmentId': departmentId.value,
        // Assuming id is auto-generated or managed by the backend
        'teacherId': teacherId.value, // Example teacher ID, replace with actual ID if needed
        'subjectId': subjectId.value,
        'day': day.value.toUpperCase(), // Convert to uppercase to match your API requirements
        'startTime': formattedStartTime,
        'endTime': formattedEndTime,
        'roomName': roomName.value,
      };
      // get token from AuthService
      final String? token = authService.getToken();

      // check if token is not null
      if (token != null) {
        // Headers for the API request
        final Map<String, String> headers = {
          'Content-Type': 'application/json',
          'Authorization': token,
        };
        print(data);
        final response = await ApiHelper.post(
          Routinecardapi.addClassEndPoint,
          headers: headers,
          body: data,


        );

          // Get.snackbar(
          //   'Success',
          //   'Student added successfully',
          //   snackPosition: SnackPosition.BOTTOM,
          // );

// Clear the form fields


      }

    else {
        Get.snackbar(
          'Error',
          'Please fill all the fields',
          snackPosition: SnackPosition.BOTTOM,
        );
      }


    }
    // formKey.currentState?.reset();
    // startTime.value = TimeOfDay.now();
    // endTime.value = TimeOfDay.now();
    // roomName.value = '';
    // teacherId.value = 0;
    // subjectId.value = 0;
    // departmentId.value = 0;
    // day.value = 'MONDAY';


  }


}
