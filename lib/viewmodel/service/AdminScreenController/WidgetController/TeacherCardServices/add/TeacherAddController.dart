import 'dart:convert';
import 'package:attendanceadmin/constant/AppUrl/SubjectCard/SubjectCardApi.dart';
import 'package:get/get.dart';
import '../../../../../../constant/AppUrl/StudentCard/StudentCardApi.dart';
import '../../../../../../constant/AppUrl/TeacherCard/TeacherCardAPi.dart';
import '../../../../../../model/login/LoginModel.dart';
import '../../../../../../model/subjectCard/subjectsListModel.dart';
import '../../../../../../model/universalmodel/departmentModel.dart';
import '../../../../LoginService/AuthServices.dart';
import '../../../../LoginService/AutharizationHeader.dart';
import 'package:http/http.dart' as http;

class AddTeacherController extends GetxController {
  final AuthService authService = AuthService();
  var teacherName = ''.obs;
  var userName = ''.obs;
  var password = ''.obs;
  var confirmPassword = ''.obs;
  var departmentIdList = <int>[].obs;
  Rx<int?> selectedDepartmentId = Rx<int?>(null);

  RxList<String> subjectsList = <String>[].obs;
  RxList<int> selectedSubjectIds = <int>[].obs;

  var selectedSubjects = <SubjectModel>[].obs;

  var subjects = <SubjectModel>[].obs;


  final RxInt departmentId = 0.obs;
  var departments = <DepartmentModel>[].obs;




  Future<void> fetchDepartments() async {
    try {
      var fetchedDepartments = await ApiHelper().fetchDepartments();
      departments.assignAll(fetchedDepartments);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load departments');
    }
  }

  void setDepartmentId(int department) {
    departmentId.value = department;
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





  @override
  void onInit() {
    super.onInit();
    getDepartmentId();
    fetchDepartments();// Fetch department IDs when the controller is initialized
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
        // for (var department in bodyDecode) {
        //   departmentIdList.add(department['id']);
        // }
      }
    }
  }



  Future<void> submit() async {
    if (teacherName.value.isNotEmpty &&
        userName.value.isNotEmpty &&
        password.value != 0 &&
        confirmPassword.value != 0 &&
        departmentId.value != 0) {
      // Json body for the API request
      final Map<String, dynamic> body = {
        'name': teacherName.value,
        'userName': userName.value,
        'password': password.value,
        'confirmPassword': confirmPassword.value,
        'deptId': int.parse(departmentId.value.toString()),
        'subjects': selectedSubjects.map((subject) => subject.id).toList(),
      };

      // Post request to add student
      await ApiHelper.post(
        Teachercardapi.createTeacherEndpoint,
        headers: await ApiHelper().getHeaders(),
        body: body,
      ).then((value) {
        Get.snackbar(
          'Success',
          'Teacher added successfully',
          snackPosition: SnackPosition.BOTTOM,
        );
        clear();
      }).catchError(
        (e) {
          Get.snackbar(
            'Error',
            'Failed to add teacher',
            snackPosition: SnackPosition.BOTTOM,
          );
        },
      );
    } else {
      Get.snackbar(
        'Error',
        'Please fill all the fields',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }


  void clearSelectedSubjects(){
    selectedSubjects.clear();
  }
  void clear() {
    teacherName.value = '';
    userName.value = '';
    password.value = '';
    confirmPassword.value = '';

    departmentId.value = 0;
  }
}
