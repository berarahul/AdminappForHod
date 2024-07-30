import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../model/universalmodel/departmentModel.dart';
import '../../../../../../viewmodel/service/AdminScreenController/WidgetController/StudentCardServices/semesterEdit/SemesterEditController.dart';

class AddSemesterScreen extends StatelessWidget {
  final SemesterController semesterController = Get.put(SemesterController());

  AddSemesterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Manage Student by Semester'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              if (semesterController.departments.isEmpty) {
                return const CircularProgressIndicator();
              } else {
                return DropdownButtonFormField<int>(
                  items: semesterController.departments.map((DepartmentModel department) {
                    return DropdownMenuItem<int>(
                      value: department.id,
                      child: Text(department.departmentName),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      semesterController.setDepartmentId(value);
                    }
                  },
                  decoration: const InputDecoration(
                    labelText: 'Department',
                    border: OutlineInputBorder(),
                  ),
                  value: semesterController.departmentId.value == 0
                      ? null
                      : semesterController.departmentId.value,
                );
              }
            }),

            const SizedBox(height: 20),

            Obx(() {
              if (semesterController.semesterNumberList.isEmpty) {
                return const CircularProgressIndicator();
              } else {
                return DropdownButtonFormField<int>(
                  hint: const Text('Select Semester Number'),
                  isExpanded: true,
                  value: semesterController.selectedSemesterNumber.value,
                  onChanged: (newValue) {
                    semesterController.selectedSemesterNumber.value = newValue!;
                    semesterController.semesterNameController.text = newValue.toString();
                  },
                  items: semesterController.semesterNumberList.map((semesterNumber) {
                    return DropdownMenuItem<int>(
                      value: semesterNumber,
                      child: Text(semesterNumber.toString()),
                    );
                  }).toList(),
                  decoration: const InputDecoration(
                    labelText: 'Semester Number',
                    border: OutlineInputBorder(),
                  ),
                );
              }
            }),

            const SizedBox(height: 40),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.blue, // Set the color of the text here
              ),
              onPressed: () {
                print("Calling...");
                semesterController.addSemester();
                print("fetch success");
                Get.snackbar('Student Transfer', "Student Transfer from your input semester to next semester");
              },
              child: const Center(child: Text('Submit')),
            ),
          ],
        ),
      ),
    );
  }
}
