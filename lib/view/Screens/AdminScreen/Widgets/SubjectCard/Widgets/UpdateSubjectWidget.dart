import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../viewmodel/service/AdminScreenController/WidgetController/StudentCardServices/update/UpdateStudentController.dart';
import '../../../../../../viewmodel/service/AdminScreenController/WidgetController/SubjectsCardService/update/updateSubjectController.dart';
// Import your actual path

class UpdateSubjectModal extends StatelessWidget {
  final Updatesubjectcontroller controller = Get.put(Updatesubjectcontroller()); // Ensure controller is initialized

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
              'Update Subject',
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
                controller.fetchSubjects(newValue!);
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
                if (controller.filteredSubjects.isEmpty) {
                  return const Center(child: Text('No students found'));
                } else {
                  return ListView.builder(
                    itemCount: controller.filteredSubjects.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(controller.filteredSubjects[index]),
                        onTap: () {
                          _showEditSubjecttModal(context, controller.filteredSubjects[index], index);
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

  void _showEditSubjecttModal(BuildContext context, String studentName, int index) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: EditSubjectModal(subjectName: studentName, index: index),
      ),
    );
  }
}

class EditSubjectModal extends StatelessWidget {
  final String subjectName;
  final int index;

  EditSubjectModal({required this.subjectName, required this.index});

  final Updatesubjectcontroller controller = Get.find<Updatesubjectcontroller>();

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController(text: subjectName);

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Edit Subject Name',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'Subject Name',
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
