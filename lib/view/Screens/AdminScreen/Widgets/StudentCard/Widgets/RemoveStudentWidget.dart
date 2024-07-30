import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../constant/AppColors.dart';
import '../../../../../../model/universalmodel/departmentModel.dart';
import '../../../../../../viewmodel/service/AdminScreenController/WidgetController/StudentCardServices/remove/RemoveStudentController.dart';

class RemoveStudentModal extends StatelessWidget {
  final RemoveStudentController controller = Get.put(RemoveStudentController());

  RemoveStudentModal({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Padding(
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

                Obx(() {
                  if (controller.departments.isEmpty) {
                    return const CircularProgressIndicator();
                  } else {
                    return DropdownButtonFormField<int>(
                      items: controller.departments
                          .map((DepartmentModel department) {
                        return DropdownMenuItem<int>(
                          value: department.id,
                          child: Text(department.departmentName),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          controller.setDepartmentId(value);
                        }
                      },
                      decoration: const InputDecoration(
                        labelText: 'Department',
                        border: OutlineInputBorder(),
                      ),
                      value: controller.departmentId.value == 0
                          ? null
                          : controller.departmentId.value,
                    );
                  }
                }),

                const SizedBox(height: 20),

                // Dropdown for selecting semester
                Obx(() {
                  return DropdownButtonFormField<int>(
                    items: controller.semesters
                        .map((semester) {
                      return DropdownMenuItem<int>(
                        value: semester,
                        child: Text(semester.toString()),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      if (newValue != null) {
                        controller.selectedSemester.value = newValue;
                        controller.fetchStudents(newValue);
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: 'Select Semester',
                      border: OutlineInputBorder(),
                    ),
                    value: controller.selectedSemester.value != 0
                        ? controller.selectedSemester.value
                        : null,
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
                          const SizedBox(height: 20),

                          Obx(() {
                            return Expanded(
                                child: controller.students.isEmpty
                                    ? const Center(
                                        child: CircularProgressIndicator())
                                    : ListView.builder(
                                        itemCount: controller.students.length,
                                        itemBuilder: (context, index) {
                                          return Obx(() {
                                            return CheckboxListTile(
                                              value: controller.selectedStudents
                                                  .contains(
                                                controller
                                                    .studentRollNumber[index],
                                              ),
                                              onChanged: (value) {
                                                controller.toggleIsUserSelected(
                                                  index: index,
                                                );
                                              },
                                              title: Text(
                                                  controller.students[index]),
                                            );
                                          });
                                        },
                                      ));
                          }),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () async {
                              await controller.removeSelectedStudents();

                              await controller.updateList();
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
        ),
      ),
    );
  }
}
