import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../viewmodel/service/AdminScreenController/WidgetController/StudentCardServices/UpdateStudentController.dart';
 // Import your actual path

class UpdateStudentModal extends StatelessWidget {
  final UpdateStudentController controller = Get.put(UpdateStudentController()); // Ensure controller is initialized

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Update Student',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            DropdownButton<String>(
              hint: const Text('Select Semester'),
              value: controller.selectedSemester.value.isEmpty ? null : controller.selectedSemester.value,
              onChanged: (newValue) {
                controller.fetchStudents(newValue!);
              },
              items: controller.semesters.map((semester) {
                return DropdownMenuItem(
                  value: semester,
                  child: Text(semester),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            TextField(
              onChanged: (value) {
                controller.searchStudents(value);
              },
              decoration: InputDecoration(
                labelText: 'Search Student',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                if (controller.filteredStudents.isEmpty) {
                  return const Center(child: Text('No students found'));
                } else {
                  return ListView.builder(
                    itemCount: controller.filteredStudents.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(controller.filteredStudents[index]),
                        onTap: () {
                          _showEditStudentModal(context, controller.filteredStudents[index], index);
                        },
                      );
                    },
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditStudentModal(BuildContext context, String studentName, int index) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: EditStudentModal(studentName: studentName, index: index),
      ),
    );
  }
}

class EditStudentModal extends StatelessWidget {
  final String studentName;
  final int index;

  EditStudentModal({required this.studentName, required this.index});

  final UpdateStudentController controller = Get.find<UpdateStudentController>();

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController(text: studentName);

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Edit Student Name',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'Student Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              controller.updateStudentName(index, nameController.text);
              Navigator.of(context).pop();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
