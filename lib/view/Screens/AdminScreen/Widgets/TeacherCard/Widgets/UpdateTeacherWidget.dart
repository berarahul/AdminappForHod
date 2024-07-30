import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:multi_select_flutter/dialog/mult_select_dialog.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import '../../../../../../model/TeacherWiseSubjectModel/teacherWiseSubjectModel.dart';
import '../../../../../../model/subjectCard/subjectsListModel.dart';
import '../../../../../../model/universalmodel/departmentModel.dart';
import '../../../../../../viewmodel/service/AdminScreenController/WidgetController/TeacherCardServices/update/TeacherUpdateController.dart';

class UpdateTeacherModal extends StatelessWidget {
  final UpdateTeacherController controller = Get.put(UpdateTeacherController());

  UpdateTeacherModal({super.key});

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
              'Update Teacher',
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
                  items:
                      controller.departments.map((DepartmentModel department) {
                    return DropdownMenuItem<int>(
                      value: department.id,
                      child: Text(department.departmentName),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      controller.setDepartmentId(value);
                      controller.fetchAllTeacher();
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
            Obx(() => controller.departmentId.value != null
                ? Expanded(
                    child: Obx(() {
                      if (controller.teacherList.isEmpty) {
                        return const Center(child: Text('No teachers found'));
                      } else {
                        return ListView.builder(
                          itemCount: controller.teacherList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(controller.teacherList[index]),
                              subtitle: Text(
                                  'Teacher id: ${controller.teacherId[index]}'),
                              trailing: IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () async {
                                  controller.storeSelectedTeacherId(
                                      controller.teacherId[index]);
                                  _showEditTeacherModal(context, index);
                                },
                              ),
                            );
                          },
                        );
                      }
                    }),
                  )
                : const SizedBox.shrink()),
          ],
        ),
      ),
    );
  }

  void _showEditTeacherModal(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: EditTeacherModal(index: index),
      ),
    );
  }
}

class EditTeacherModal extends StatefulWidget {
  final int index;

  const EditTeacherModal({super.key, required this.index});

  @override
  State<EditTeacherModal> createState() => _EditTeacherModalState();
}

final UpdateTeacherController controller = Get.find<UpdateTeacherController>();

class _EditTeacherModalState extends State<EditTeacherModal> {
  @override
  void initState() {
    controller.nameController.text = controller.teacherList[widget.index];
    controller.teacherIdController.text =
        controller.teacherId[widget.index].toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Edit Teacher Name',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: controller.nameController,
            decoration: const InputDecoration(
              labelText: 'Teacher Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          // TextField(
          //   controller: controller.teacherIdController,
          //   decoration: const InputDecoration(
          //     labelText: 'Teacher ID',
          //     border: OutlineInputBorder(),
          //   ),
          // ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue, // Set the color of the text here
            ),
            onPressed: () {
              controller.fetchsubjects();
              _showSubjectsDialog(context);
            },
            child: const Center(child: Text('Select Subjects')),
          ),
          const SizedBox(height: 20),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue, // Set the color of the text here
            ),
            onPressed: () {
              controller.secondtimefetchsubjects();
              _showRemoveSubjectsDialog(context);
            },
            child: const Center(child: Text('Remove Subjects')),
          ),
          const SizedBox(height: 20),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.green, // Set the color of the text here
            ),
            onPressed: () async {
              if (controller.nameController.text.isNotEmpty ||
                  controller.selectedSubjects.isNotEmpty ||
                  controller.selectedRemoveSubjects.isNotEmpty) {
                if (controller.selectedSubjects.isNotEmpty) {
                  await controller.updateTeacherWithSubjects();
                  Get.snackbar("Success", "Subject Added Successfully");
                } else if (controller.selectedRemoveSubjects.isNotEmpty) {
                  await controller.updateTeacherWithoutSubjects();
                  Get.snackbar("Success", "Subject Removed Successfully");
                } else {
                  // Handle case where only name is updated
                  await controller.updateTeacherNameOnly();
                  Get.snackbar("Success", "Teacher Updated Successfully");
                }
              } else {
                Get.snackbar("Error", "No changes to update");
              }
            },
            child: const Text(
              'Update Teacher',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _showSubjectsDialog(BuildContext context) {
    controller.fetchsubjects().then((_) {
      controller.clearSelectedSubjects();

      showDialog(
        context: context,
        builder: (context) {
          return MultiSelectDialog(
            backgroundColor: Colors.white,
            items: controller.subjects
                .map((subject) => MultiSelectItem(subject, subject.subName!))
                .toList(),
            initialValue: controller.selectedSubjects.toList(),
            onConfirm: (values) {
              setState(() {
                controller.selectedSubjects
                    .assignAll(values.cast<SubjectModel>());
                print(
                    'Selected Subjects: ${controller.selectedSubjects.map((subject) => subject.id).toList()}');
              });
            },
          );
        },
      );
    });
  }

  void _showRemoveSubjectsDialog(BuildContext context) {
    controller.secondtimefetchsubjects().then((_) {
      controller.clearSelectedRemoveSubjects();

      showDialog(
        context: context,
        builder: (context) {
          return MultiSelectDialog(
            backgroundColor: Colors.white,
            items: controller.subjects2
                .map(
                    (subject) => MultiSelectItem(subject, subject.subjectName!))
                .toList(),
            initialValue: controller.selectedRemoveSubjects.toList(),
            onConfirm: (values) {
              setState(() {
                controller.selectedRemoveSubjects
                    .assignAll(values.cast<TeacherwiseSubjectModel>());
                print(
                    'Selected Subjects for Remove: ${controller.selectedRemoveSubjects.map((subject) => subject.subjectId).toList()}');
              });
            },
          );
        },
      );
    });
  }
}
