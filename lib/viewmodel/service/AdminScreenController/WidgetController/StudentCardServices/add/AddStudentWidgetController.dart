// import 'dart:convert';
//
// import 'package:attendanceadmin/constant/AppUrl/StudentCard/StudentCardApi.dart';
// import 'package:attendanceadmin/viewmodel/service/LoginService/AuthServices.dart';
// import 'package:get/get.dart';
//
// import '../../../../LoginService/AutharizationHeader.dart';
//
// class AddStudentController extends GetxController {
//   // Instance of AuthService
//   final AuthService authService = AuthService();
//
//   var studentName = ''.obs;
//
//   final RxString studentId = ''.obs;
//
//   final RxInt rollNum = 0.obs;
//
//   final RxInt departmentId = 0.obs;
//
//   final RxInt semesterId = 0.obs;
//
//   void setStudentName(String name) {
//     studentName.value = name;
//   }
//
//   void setRollNum(int rollNumber) {
//     rollNum.value = rollNumber;
//   }
//
//   void setStudentId(String studentID) {
//     studentId.value = studentID;
//   }
//
//   void setDepartmentId(int department) {
//     departmentId.value = department;
//   }
//
//   void setSemesterId(int semester) {
//     semesterId.value = semester;
//   }
//
//   Future<void> submit() async {
//     if (studentName.value.isNotEmpty &&
//         studentId.value.isNotEmpty &&
//         rollNum.value != 0 &&
//         departmentId.value != 0 &&
//         semesterId.value != 0) {
//       // get token from AuthService
//       final String? token = authService.getToken();
//
//       // check if token is not null
//       if (token != null) {
//         // Headers for the API request
//         final Map<String, String> headers = {
//           'Content-Type': 'application/json',
//           'Authorization': token,
//         };
//
//         // Json body for the API request
//         final Map<String, dynamic> body = {
//           'name': studentName.value,
//           'roll': rollNum.value,
//           'studentId': studentId.value,
//           'deptId': departmentId.value,
//           'semesterId': semesterId.value,
//         };
//
//         // Post request to add student
//         await ApiHelper.post(
//           StudentCardApi.addStudentEndPoint,
//           headers: headers,
//           body: body,
//         );
//
//         Get.snackbar(
//           'Success',
//           'Student added successfully',
//           snackPosition: SnackPosition.BOTTOM,
//         );
//
//         clear();
//       }
//     } else {
//       Get.snackbar(
//         'Error',
//         'Please fill all the fields',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     }
//   }
//
//   void clear() {
//     studentName.value = '';
//     studentId.value = '';
//     rollNum.value = 0;
//     departmentId.value = 0;
//     semesterId.value = 0;
//   }
// }






import 'package:attendanceadmin/constant/AppUrl/StudentCard/StudentCardApi.dart';
import 'package:attendanceadmin/viewmodel/service/LoginService/AuthServices.dart';
import 'package:get/get.dart';
import 'dart:convert';
import '../../../../../../model/departmentModel.dart';
import '../../../../LoginService/AutharizationHeader.dart';


class AddStudentController extends GetxController {
  // Instance of AuthService
  final AuthService authService = AuthService();

  var studentName = ''.obs;
  final RxString studentId = ''.obs;
  final RxInt rollNum = 0.obs;

  final RxInt semesterId = 0.obs;
  final RxInt departmentId = 0.obs;
  var departments = <DepartmentModel>[].obs;

  @override
  void onInit() {
    fetchDepartments();
    super.onInit();
  }

  Future<void> fetchDepartments() async {
    try {
      var fetchedDepartments = await ApiHelper().fetchDepartments();
      departments.assignAll(fetchedDepartments);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load departments');
    }
  }


  void setStudentName(String name) {
    studentName.value = name;
  }

  void setRollNum(int rollNumber) {
    rollNum.value = rollNumber;
  }

  void setStudentId(String studentID) {
    studentId.value = studentID;
  }

  void setDepartmentId(int department) {
    departmentId.value = department;
  }

  void setSemesterId(int semester) {
    semesterId.value = semester;
  }



  Future<void> submit() async {
    if (studentName.value.isNotEmpty &&
        studentId.value.isNotEmpty &&
        rollNum.value != 0 &&
        departmentId.value != 0 &&
        semesterId.value != 0) {
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
          'name': studentName.value,
          'roll': rollNum.value,
          'studentId': studentId.value,
          'deptId': departmentId.value,
          'semesterId': semesterId.value,
        };

        // Post request to add student
        await ApiHelper.post(
          StudentCardApi.addStudentEndPoint,
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
    studentName.value = '';
    studentId.value = '';
    rollNum.value = 0;
    departmentId.value = 0;
    semesterId.value = 0;
  }
}
