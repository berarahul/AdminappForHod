import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TeacherUpdateController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  RxList<String> teacherList = [
    'John Doe',
    'Jane Smith',
    'Michael Johnson',
    'Emily Brown',
    'Robert Wilson',
  ].obs;

  void selectTeacher(String teacherName) {
    nameController.text = teacherName;
  }

  void editTeacherName(int index, String newName) {
    teacherList[index] = newName;
  }

  Future<void> updateTeacher() async {
    final teacherId = 123; // Example teacher ID
    // Simulated HTTP request to update teacher
    await Future.delayed(Duration(seconds: 2)); // Simulate delay

    // Replace with actual HTTP request using http package or another package of your choice
    /*
    final response = await http.put(
      Uri.parse('https://api.example.com/teachers/$teacherId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "teacherId": teacherId,
        "name": nameController.text,
        // Add other fields as needed
      }),
    );

    if (response.statusCode == 200) {
      Get.snackbar('Success', 'Teacher updated successfully');
    } else {
      Get.snackbar('Error', 'Failed to update teacher: ${response.statusCode}');
    }
    */
    Get.snackbar('Success', 'Teacher updated successfully');
  }

  Future<void> TearchList() async{



  }

}
