// add_semester_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../viewmodel/service/AdminScreenController/WidgetController/StudentCardServices/semesterEdit/SemesterEditController.dart';


class AddSemesterScreen extends StatelessWidget {
  final SemesterController semesterController = Get.put(SemesterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Semester'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: semesterController.semesterNameController,
              decoration: InputDecoration(
                labelText: 'Semester Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: semesterController.addSemester,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
