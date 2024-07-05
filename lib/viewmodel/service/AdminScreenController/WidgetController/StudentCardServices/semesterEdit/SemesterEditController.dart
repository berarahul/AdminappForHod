// semester_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SemesterController extends GetxController {
  final semesterNameController = TextEditingController();

  Future<void> addSemester() async {
    final name = semesterNameController.text.trim();
    if (name.isNotEmpty) {
      final url = 'https://your-api-endpoint.com/addSemester'; // Replace with your API endpoint
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'name': name}),
      );

      if (response.statusCode == 200) {
        // Clear the text field after adding the semester
        semesterNameController.clear();
        Get.snackbar('Success', 'Semester added successfully');
      } else {
        Get.snackbar('Error', 'Failed to add semester');
      }
    } else {
      Get.snackbar('Error', 'Semester name cannot be empty');
    }
  }

  @override
  void onClose() {
    semesterNameController.dispose();
    super.onClose();
  }
}
