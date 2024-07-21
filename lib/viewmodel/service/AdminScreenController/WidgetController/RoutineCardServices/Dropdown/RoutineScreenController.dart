// // controllers/schedule_controller.dart
//
// import 'dart:convert';
//
// import 'package:get/get.dart';
//
// import '../../../../../../model/RoutineModel/ClassSheduleModel.dart';
// import 'fetchSheduleController.dart';
//
//
//
// class ScheduleController extends GetxController {
//   var schedule = <String, List<Schedule>>{}.obs;
//   var isLoading = true.obs;
//
//   @override
//   void onInit() {
//     fetchAndSetSchedule();
//     super.onInit();
//   }
//
//   Future<void> fetchAndSetSchedule() async {
//     try {
//       isLoading(true);
//       schedule.value = await fetchSchedule();
//     } finally {
//       isLoading(false);
//     }
//   }
//
//   Future<void> updateShedule() async {
//
//
//
//   }
//
// }


//
//
// // controllers/schedule_controller.dart
//
// import 'dart:convert';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import '../../../../../../model/RoutineModel/ClassSheduleModel.dart';
// import 'fetchSheduleController.dart';
//
// class ScheduleController extends GetxController {
//   // Define the schedule as a Map<String, List<Schedule>> observable
//   var schedule = <String, List<Schedule>>{}.obs;
//   var isLoading = true.obs;
//
//   @override
//   void onInit() {
//     fetchAndSetSchedule();
//     super.onInit();
//   }
//
//   Future<void> fetchAndSetSchedule() async {
//     try {
//       isLoading(true);
//       schedule.value = await fetchSchedule();
//     } finally {
//       isLoading(false);
//     }
//   }
//
//   Future<void> updateSchedule(String day, Schedule updatedSchedule) async {
//     try {
//       isLoading(true);
//
//       final updateData = {
//         'day': day,
//         'roomName': updatedSchedule.roomName,
//         'startingTime': updatedSchedule.startingTime,
//         'endingTime': updatedSchedule.endingTime,
//         'teacherId': updatedSchedule.teacherId,
//         'subjectId': updatedSchedule.subjectId,
//       };
//
//       // Replace 'YOUR_API_ENDPOINT' with your actual API endpoint
//       final response = await http.put(
//         Uri.parse('YOUR_API_ENDPOINT'),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode(updateData),
//       );
//
//       if (response.statusCode == 200) {
//         // Successfully updated on the server
//         final List<Schedule> daySchedule = schedule[day]!;
//         final index = daySchedule.indexWhere((s) =>
//         s.subName == updatedSchedule.subName &&
//             s.paperCode == updatedSchedule.paperCode);
//
//         if (index != -1) {
//           daySchedule[index] = updatedSchedule;
//           schedule[day] = List.from(daySchedule); // Trigger the reactive update
//         }
//       } else {
//         throw Exception('Failed to update schedule');
//       }
//     } finally {
//       isLoading(false);
//     }
//   }
// }












import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../../../model/RoutineModel/ClassSheduleModel.dart';
import '../../../../LoginService/AutharizationHeader.dart';
import 'fetchSheduleController.dart';
 // Ensure ApiHelper is imported

class ScheduleController extends GetxController {
  var schedule = <String, List<Schedule>>{}.obs;
  var isLoading = true.obs;
  final ApiHelper apiHelper = ApiHelper(); // Initialize ApiHelper

  @override
  void onInit() {
    fetchAndSetSchedule();
    super.onInit();
  }

  Future<void> fetchAndSetSchedule() async {
    try {
      isLoading(true);
      schedule.value = await fetchSchedule();
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateSchedule(String day, Schedule updatedSchedule) async {
    try {
      isLoading(true);

      // Prepare the update data
      final updateData = {
         // Assuming ID is required for update
        'teacherId': updatedSchedule.teacherId,
        'subjectId': updatedSchedule.subjectId,
        'day': day,
        'startTime': updatedSchedule.startingTime,
        'endTime':updatedSchedule.endingTime,
        'roomName': updatedSchedule.roomName,
        'id': updatedSchedule.id,
      };

      // Call update method from ApiHelper
      final response = await ApiHelper.update(
        'classRoutine/updateRoutine', // Replace with your actual endpoint
        headers: await apiHelper.getHeaders(),
        body: updateData,

      );
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      print(updateData);
      if (response.statusCode == 200) {
        // Successfully updated on the server
        final List<Schedule> daySchedule = schedule[day]!;
        final index = daySchedule.indexWhere((s) =>
        s.subName == updatedSchedule.subName &&
            s.paperCode == updatedSchedule.paperCode
        );

        if (index != -1) {
          daySchedule[index] = updatedSchedule;
          schedule[day] = List.from(daySchedule); // Trigger the reactive update
        }

        Get.snackbar("Success", "Schedule updated successfully");
      } else {
        throw Exception('Failed to update schedule');
      }
    } catch (error) {
      Get.snackbar("Error", "Failed to update schedule: $error");
      print('Error updating schedule: $error');
    } finally {
      isLoading(false);
    }
  }
}
