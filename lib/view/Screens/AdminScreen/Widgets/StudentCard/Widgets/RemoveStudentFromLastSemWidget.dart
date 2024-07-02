import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../viewmodel/service/AdminScreenController/WidgetController/StudentCardServices/removelastsemController.dart';

class Removestudentfromlastsemwidget extends StatelessWidget {
  final RemoveStudentControllerFromLastSem controller = Get.put(RemoveStudentControllerFromLastSem());

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
              'Remove Student',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              onChanged: (value) {
                controller.filterSearchResults(value);
              },
              decoration: const InputDecoration(
                labelText: 'Search Students',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Obx(() => Checkbox(
                  value: controller.selectedStudents.length == controller.filteredStudents.length && controller.filteredStudents.isNotEmpty,
                  onChanged: (value) {
                    controller.selectAllStudents(value!);
                  },
                )),
                const Text('Select All'),
              ],
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
                      final student = controller.filteredStudents[index];
                      return CheckboxListTile(
                        title: Text(student),
                        value: controller.selectedStudents.contains(student),
                        onChanged: (value) {
                          controller.addOrRemoveStudent(student, value!);
                        },
                      );

                    },
                  );
                }
              }),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                controller.removeSelectedStudents();
                Navigator.of(context).pop();
              },
              child: const Text('Remove Selected Students'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
