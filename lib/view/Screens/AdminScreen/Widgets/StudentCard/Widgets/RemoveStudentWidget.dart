import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../constant/AppColors.dart';
import '../../../../../../viewmodel/service/AdminScreenController/WidgetController/StudentCardServices/remove/RemoveStudentController.dart';

class RemoveStudentModal extends StatelessWidget {
  final RemoveStudentController controller = Get.put(RemoveStudentController());

  RemoveStudentModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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

            // Dropdown for selecting department id
            // Dropdown for selecting department id
            Obx(() {
              return DropdownButton<int>(
                  alignment: Alignment.center,
                  hint: controller.departmentIdList.isEmpty
                      ? const Center(child: CircularProgressIndicator())
                      : const Text('Select Department'),
                  borderRadius: BorderRadius.circular(8),
                  isExpanded: true,
                  value: controller.selectedDepartmentId.value,
                  onChanged: (newValue) {
                    // Update the selectedDepartmentId with the new value
                    controller.selectedDepartmentId.value = newValue!;
                  },
                  items: controller.departmentIdList.map((departmentId) {
                    return DropdownMenuItem<int>(
                      value: departmentId,
                      child: Text(departmentId.toString()),
                    );
                  }).toList());
            }),

            const SizedBox(height: 20),

            // Dropdown for selecting semester
            Obx(() {
              return DropdownButton<int>(
                alignment: Alignment.center,
                hint: const Text('Select Semester'),
                borderRadius: BorderRadius.circular(8),
                isExpanded: true,
                value: controller.selectedSemester.value != 0
                    ? controller.selectedSemester.value
                    : null,
                onChanged: (newValue) {
                  controller.selectedSemester.value = newValue!;
                  controller.fetchStudents(newValue);
                },
                items: controller.semesters.map((semester) {
                  return DropdownMenuItem(
                    value: semester,
                    child: Text(semester.toString()),
                  );
                }).toList(),
              );
            }),
            const SizedBox(height: 20),
            Obx(() {
              if (controller.selectedSemester.value == null) {
                return Container();
              } else {
                return Expanded(
                  child: Column(
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
                          //Todo: Need to impl this
                          Checkbox(
                            value: false,
                            onChanged: (value) {
                              controller.selectAllStudents(value!);
                            },
                          ),
                          const Text('Select All'),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Obx(() {
                        return Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.students.length,
                            itemBuilder: (context, index) {
                              final student = controller.students[index];
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
                          ),
                        );
                      }),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          controller.removeSelectedStudents();
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        child: const Text('Remove Selected Students'),
                      ),
                    ],
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
