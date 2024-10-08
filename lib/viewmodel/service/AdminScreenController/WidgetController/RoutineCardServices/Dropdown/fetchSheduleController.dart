// services/api_service.dart

import 'dart:convert';
import 'package:attendanceadmin/constant/AppUrl/RoutineCard/RoutineCardApi.dart';
import 'package:http/http.dart' as http;

import '../../../../../../model/RoutineModel/ClassSheduleModel.dart';



Future<Map<String, List<Schedule>>> fetchSchedule() async {
  final url = Routinecardapi.fetchRoutine;  // Replace with your actual API URL

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    Map<String, dynamic> data = json.decode(response.body);
    Map<String, List<Schedule>> schedule = {};

    data.forEach((day, list) {
      schedule[day] = (list as List).map((e) => Schedule.fromJson(e)).toList();
    });

    return schedule;
  } else {
    throw Exception('Failed to load schedule');
  }
}
