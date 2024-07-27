// import 'package:attendanceadmin/constant/AppUrl/RoutineCard/RoutineCardApi.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// import '../../../../../../../viewmodel/service/AdminScreenController/WidgetController/RoutineCardServices/Dropdown/DepartmentController.dart';
// import '../../../../../../../viewmodel/service/AdminScreenController/WidgetController/RoutineCardServices/Dropdown/SemesterController.dart';
// import 'ScheduleScreen.dart';
// import 'Widgets/DepartmentDropdown.dart';
// import 'Widgets/SemesterDropdown.dart';
//
//
// class DropdownScreenForRoutine extends StatelessWidget {
//   final DepartmentController departmentController = Get.put(DepartmentController());
//   final SemesterControllerD semesterController = Get.put(SemesterControllerD());
//   final RxBool isLoading = false.obs;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   automaticallyImplyLeading: false,
//       //   backgroundColor: Colors.blue,
//       //   title: const Center(child: Text("Routine")),
//       // ),
//
//       body: Obx(() {
//         return SingleChildScrollView(
//
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: 45,),
//                 DepartmentDropdown(),
//                 SizedBox(height: 20),
//                 SemesterDropdown(),
//                 SizedBox(height: 250),
//                 Center(
//                   child: ElevatedButton(
//                     onPressed: () async {
//                       final selectedDeptId = departmentController.selectedDepartmentId.value;
//                       final selectedSemId = semesterController.selectedSemesterId.value;
//
//                       print("Selected Department ID: $selectedDeptId");
//                       print("Selected Semester ID: $selectedSemId");
//
//                       if (selectedDeptId == 0 || selectedSemId == 0) {
//                         Get.snackbar("Error", "Please select both Department and Semester.");
//                         return;
//                       }
//
//                       final apiUrl = Routinecardapi.fetchRoutine;
//                       print("API URL: $apiUrl");
//
//                       isLoading.value = true;
//
//                       try {
//                         final response = await http.get(Uri.parse(apiUrl));
//
//                         if (response.statusCode == 200) {
//                           var data = jsonDecode(response.body);
//                           print("API Response Data: $data");
//                           Get.to(() => ScheduleScreen());
//                           Get.snackbar("Success", "Data fetched successfully.");
//
//                         } else {
//                           Get.snackbar("Error", "Failed to fetch data. Status code: ${response.statusCode}");
//                         }
//                       } catch (e) {
//                         Get.snackbar("Error", "An error occurred: $e");
//                       } finally {
//
//                         isLoading.value = false;
//                       }
//                     },
//                     style: ElevatedButton.styleFrom(
//                       foregroundColor: Colors.white, backgroundColor: Colors.blue,
//                       padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
//                       minimumSize: Size(200, 60),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                       elevation: 5,
//                     ),
//                     child: isLoading.value
//                         ? const SizedBox(
//                       width: 24,
//                       height: 24,
//                       child: CircularProgressIndicator(
//                         color: Colors.black,
//                         strokeWidth: 2,
//                       ),
//                     )
//                         : const Text('Submit', style: TextStyle(fontSize: 16)),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       }),
//     );
//   }
// }
//



import 'package:attendanceadmin/constant/AppUrl/RoutineCard/RoutineCardApi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../../../../../viewmodel/service/AdminScreenController/WidgetController/RoutineCardServices/Dropdown/DepartmentController.dart';
import '../../../../../../../viewmodel/service/AdminScreenController/WidgetController/RoutineCardServices/Dropdown/SemesterController.dart';
import 'ScheduleScreen.dart';
import 'Widgets/DepartmentDropdown.dart';
import 'Widgets/SemesterDropdown.dart';

class DropdownScreenForRoutine extends StatelessWidget {
  final DepartmentController departmentController = Get.put(DepartmentController());
  final SemesterControllerD semesterController = Get.put(SemesterControllerD());
  final RxBool isLoading = false.obs;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Dropdown For Routine",),
      ),
      body: Obx(() {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 45),
                DepartmentDropdown(),
                const SizedBox(height: 20),
                SemesterDropdown(),
                const SizedBox(height: 250),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      final selectedDeptId = departmentController.selectedDepartmentId.value;
                      final selectedSemId = semesterController.selectedSemesterId.value;

                      print("Selected Department ID: $selectedDeptId");
                      print("Selected Semester ID: $selectedSemId");

                      if (selectedDeptId == 0 || selectedSemId == 0) {
                        Get.snackbar("Error", "Please select both Department and Semester.");
                        return;
                      }

                      final apiUrl = Routinecardapi.fetchRoutine;
                      print("API URL: $apiUrl");

                      isLoading.value = true;

                      try {
                        final response = await http.get(Uri.parse(apiUrl));

                        if (response.statusCode == 200) {
                          var data = jsonDecode(response.body);
                          print("API Response Data: $data");
                          Get.to(() => ScheduleScreen());
                          Get.snackbar("Success", "Data fetched successfully.");
                        } else {
                          Get.snackbar("Error", "Failed to fetch data. Status code: ${response.statusCode}");
                        }
                      } catch (e) {
                        Get.snackbar("Error", "An error occurred: $e");
                      } finally {
                        isLoading.value = false;
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: theme.colorScheme.onPrimary, backgroundColor: theme.primaryColor, // Adapt text color to theme
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                      minimumSize: const Size(200, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 5,
                    ),
                    child: isLoading.value
                        ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: Colors.black,
                        strokeWidth: 2,
                      ),
                    )
                        : Text('Submit', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
