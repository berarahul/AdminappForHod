



import 'dart:convert';
import 'package:attendanceadmin/constant/AppUrl/SubjectCard/SubjectCardApi.dart';
import 'package:get/get.dart';
import '../../../../../../constant/AppUrl/StudentCard/StudentCardApi.dart';
import '../../../../../../constant/AppUrl/TeacherCard/TeacherCardAPi.dart';
import '../../../../../../model/LoginModel.dart';
import '../../../../LoginService/AuthServices.dart';
import '../../../../LoginService/AutharizationHeader.dart';

class AddSubjectController extends GetxController {
  final AuthService authService = AuthService();
  var teacherName = ''.obs;
  var userName = ''.obs;
  var password = ''.obs;
  var confirmPassword = ''.obs;
  var departmentIdList = <int>[].obs;
  Rx<int?> selectedDepartmentId = Rx<int?>(null);

  RxList<String> subjectsList = <String>[].obs;
  RxList<int> selectedSubjectIds = <int>[].obs;

  @override
  void onInit() {
    super.onInit();
    getDepartmentId(); // Fetch department IDs when the controller is initialized
  }

  // Setters for observable properties
  void setTeacherName(String value) {
    teacherName.value = value;
  }

  void setUserName(String value) {
    userName.value = value;
  }

  void setPassword(String value) {
    password.value = value;
  }

  void setConfirmPassword(String value) {
    confirmPassword.value = value;
  }

  void setSelectedDepartmentId(int? value) {
    selectedDepartmentId.value = value;
  }

  Future<void> getDepartmentId() async {
    final UserModel? userModel = authService.getUserModel();
    if (userModel != null) {
      final response = await ApiHelper.get(
        "${Teachercardapi.teacherEndPoint}/${userModel.id}",
        headers: await ApiHelper().getHeaders(),
      );

      if (response.statusCode == 200) {
        final List<dynamic> bodyDecode = jsonDecode(response.body);
        for (var department in bodyDecode) {
          departmentIdList.add(department['id']);
        }
      }
    }
  }
  Future<void> fetchallSubjects() async {
    try {
      if (selectedDepartmentId.value == null) {
        print('Error: Selected department ID is null');
        return;
      }

      String endpoint =
          "${StudentCardApi.departmentListEndPoint}/${Subjectcardapi.subjectEndPoint}/${selectedDepartmentId.value}";

      var response =
      await ApiHelper.get(endpoint, headers: await ApiHelper().getHeaders());

      if (response.statusCode == 200) {
        Map<String, dynamic> decodedData = jsonDecode(response.body);

        if (decodedData.containsKey('subjects') &&
            decodedData['subjects'] is List) {
          List<dynamic> subjectsListResponse = decodedData['subjects'];

          subjectsList.clear();

          subjectsListResponse.forEach((subject) {
            String subjectId = subject['subjectId'].toString(); // Assuming subjectId is an int
            subjectsList.add(subjectId);
          });
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

  Future<void> submit() async {
    if (teacherName.value.isNotEmpty &&
        userName.value.isNotEmpty &&
        password.value != 0 &&
        confirmPassword.value != 0 &&
        selectedDepartmentId.value != 0) {
      // get token from AuthService
      final String? token = authService.getToken();

      // check if token is not null
      if (token != null) {
        // Headers for the API request
        final Map<String, String> headers = {
          'Content-Type': 'application/json',
          'Authorization': token,
        };

        // Json body for the API request
        final Map<String, dynamic> body = {
          'name': teacherName.value,
          'userName': userName.value,
          'password': password.value,
          'confirmPassword': confirmPassword.value,
          'deptId': selectedDepartmentId.value,
        };

        // Post request to add student
        await ApiHelper.post(
          Teachercardapi.createTeacherEndpoint,
          headers: headers,
          body: body,
        );

        Get.snackbar(
          'Success',
          'Student added successfully',
          snackPosition: SnackPosition.BOTTOM,
        );

        clear();
      }
    } else {
      Get.snackbar(
        'Error',
        'Please fill all the fields',
        snackPosition: SnackPosition.BOTTOM,
      );
    }

  }

  void clear() {
    teacherName.value = '';
    userName.value = '';
    password.value = '';
    confirmPassword.value = '';

    selectedDepartmentId.value = null;




  }

}
