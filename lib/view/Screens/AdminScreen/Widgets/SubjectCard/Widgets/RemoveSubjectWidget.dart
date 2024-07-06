import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../constant/AppColors.dart';
import '../../../../../../viewmodel/service/AdminScreenController/WidgetController/StudentCardServices/remove/RemoveStudentController.dart';
import '../../../../../../viewmodel/service/AdminScreenController/WidgetController/SubjectsCardService/remove/removesubjectController.dart';
import '../../StudentCard/Widgets/UpdateStudentWidget.dart';

class RemoveSubjectModal extends StatelessWidget {
  final RemoveSubjectController controller = Get.put(RemoveSubjectController());

  RemoveSubjectModal({super.key});

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
                  'Remove Subject',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),

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
                          //Todo: Need to impl this
                          // Row(
                          //   children: [
                          //     Checkbox(
                          //       value: false,
                          //       onChanged: (value) {
                          //         controller.selectAllStudents(value!);
                          //       },
                          //     ),
                          //     const Text('Select All'),
                          //   ],
                          // ),
                          // const SizedBox(height: 20),

                          Obx(() {
                            // Ensure subjectslistmodel.value and subjectslistmodel.value.subjects are not null
                            var subjectsListModel =
                                controller.subjectslistmodel.value;
                            var subjects = subjectsListModel?.subjects ?? [];

                            return Expanded(
                              child: subjects.isEmpty
                                  ? const Center(
                                      child: CircularProgressIndicator())
                                  : ListView.builder(
                                      itemCount: subjects.length,
                                      itemBuilder: (context, index) {
                                        var subject = subjects[index];

                                        return Obx(() => ListTile(
                                              title: Text(subject.subName ??
                                                  'Unknown'), // Provide a default value for subName if null
                                              trailing: Checkbox(
                                                value: controller
                                                        .selectedSubject
                                                        .value ==
                                                    subject.subjectId,
                                                onChanged: (value) {
                                                  controller.addOrRemoveStudent(
                                                      index: index);
                                                },
                                              ),
                                            ));
                                      },
                                    ),
                            );
                          }),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () async {
                              await controller.removeSelectedSubjects();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            child: const Text('Remove Selected Subjects'),
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
