import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../constant/AppColors.dart';
import '../../../../../../viewmodel/service/AdminScreenController/WidgetController/StudentCardServices/RemoveStudentController.dart';

class RemoveStudentModal extends StatelessWidget {
  final RemoveStudentController controller = Get.put(RemoveStudentController());

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
            Obx(() {
              return DropdownButton<String>(
                hint: const Text('Select Semester'),
                value: controller.selectedSemester.value.isEmpty
                    ? null
                    : controller.selectedSemester.value,
                onChanged: (newValue) {
                  controller.selectedSemester.value = newValue!;
                  controller.fetchStudents(newValue);
                },
                items: controller.semesters.map((semester) {
                  return DropdownMenuItem(
                    value: semester,
                    child: Text(semester),
                  );
                }).toList(),
              );
            }),
            const SizedBox(height: 20),
            Obx(() {
              if (controller.selectedSemester.value.isEmpty) {
                return Container();
              } else {
                return Column(
                  children: [
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
                        Checkbox(
                          value: controller.selectedStudents.length ==
                              controller.filteredStudents.length,
                          onChanged: (value) {
                            controller.selectAllStudents(value!);
                          },
                        ),
                        const Text('Select All'),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Obx(() {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.filteredStudents.length,
                        itemBuilder: (context, index) {
                          final student =
                          controller.filteredStudents[index];
                          return CheckboxListTile(
                            title: Text(student),
                            value: controller.selectedStudents
                                .contains(student),
                            onChanged: (value) {
                              controller.addOrRemoveStudent(
                                  student, value!);
                            },
                          );
                        },
                      );
                    }),
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
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
