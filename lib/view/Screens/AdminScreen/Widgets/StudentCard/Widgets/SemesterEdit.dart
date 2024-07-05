import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../viewmodel/service/AdminScreenController/WidgetController/StudentCardServices/semesterEdit/SemesterEditController.dart';

class AddSemesterScreen extends StatelessWidget {
  final SemesterController semesterController = Get.put(SemesterController());

  AddSemesterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Semester'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Obx(
              () => DropdownButton<int>(
                  alignment: Alignment.center,
                  hint: semesterController.departmentIdList.isEmpty
                      ? const Center(child: CircularProgressIndicator())
                      : const Text('Select Department'),
                  borderRadius: BorderRadius.circular(8),
                  isExpanded: true,
                  value: semesterController.selectedDepartmentId.value,
                  onChanged: (newValue) async {
                    // Update the selectedDepartmentId with the new value
                    semesterController.selectedDepartmentId.value = newValue!;
                  },
                  items:
                      semesterController.departmentIdList.map((departmentId) {
                    return DropdownMenuItem<int>(
                      value: departmentId,
                      child: Text(departmentId.toString()),
                    );
                  }).toList()),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: semesterController.semesterNameController,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                labelText: 'Semester Number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async => await semesterController.addSemester(),
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
