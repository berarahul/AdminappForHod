import 'dart:convert';
import 'package:attendanceadmin/constant/AppUrl/SubjectCard/SubjectCardApi.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import '../../../../../../constant/AppUrl/StudentCard/StudentCardApi.dart';
import '../../../../../../constant/AppUrl/TeacherCard/TeacherCardAPi.dart';
import '../../../../../../model/LoginModel.dart';
import '../../../../LoginService/AuthServices.dart';
import '../../../../LoginService/AutharizationHeader.dart';

class AddSubjectController extends GetxController {
  final AuthService authService = AuthService();
  RxString subjectName = ''.obs;
  Rx<int?> semesterId = Rx<int?>(null);
  var departmentIdList = <int>[].obs;
  Rx<int?> selectedDepartmentId = Rx<int?>(null);
  Rx<int?> subId = Rx<int?>(null);


  @override
  void onInit() {
    super.onInit();
    getDepartmentId(); // Fetch department IDs when the controller is initialized
  }

  // Setters for observable properties
  void setSubjectName(String value) {
    subjectName.value = value;
  }

  void setSemesterId(int? value) {
    semesterId.value = value;
  }

  void setSubId(int? value) {
    subId.value = value;
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

  Future<void> submit() async {
    if (subjectName.value.isNotEmpty &&
        semesterId.value!=0 &&
        subId.value != 0 &&

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



          "name": subjectName.value,
          "deptId": selectedDepartmentId.value,
          "semesterId": semesterId.value,
          "subId": subId.value,

        };

        // Post request to add student
        await ApiHelper.post(
          Subjectcardapi.subjectCreateEndpoint,
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
    subjectName.value = '';
    subId.value = null;
    semesterId.value = null;
    selectedDepartmentId.value = null;

  }

}
