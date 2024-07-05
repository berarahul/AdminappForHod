import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../viewmodel/service/AdminScreenController/WidgetController/StudentCardServices/update/UpdateStudentController.dart';
// Import your actual path

class UpdateStudentModal extends StatelessWidget {
  final UpdateStudentController controller = Get.put(UpdateStudentController());

  UpdateStudentModal({super.key}); // Ensure controller is initialized

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
              'Update Student',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Obx(() => DropdownButton<int>(
                  hint: controller.departmentIdList.isEmpty
                      ? const Text('Loading...')
                      : const Text('Select Department'),
                  value: controller.selectedDepartment.value,
                  onChanged: (newValue) {
                    controller.selectedDepartment.value = newValue;
                  },
                  items: controller.departmentIdList.map((department) {
                    return DropdownMenuItem(
                      value: department,
                      child: Text(department.toString()),
                    );
                  }).toList(),
                )),
            const SizedBox(height: 20),
            Obx(() => DropdownButton<int>(
                  hint: const Text('Select Semester'),
                  value: controller.selectedSemester.value,
                  onChanged: (newValue) async {
                    controller.selectedSemester.value = newValue;

                    await controller.fetchAllStudent();
                  },
                  items: controller.semestersList.map((semester) {
                    return DropdownMenuItem(
                      value: semester,
                      child: Text(semester.toString()),
                    );
                  }).toList(),
                )),
            const SizedBox(height: 20),
            Obx(() => controller.selectedDepartment.value != null &&
                    controller.selectedSemester.value != null
                ? Expanded(
                    child: Obx(() {
                      if (controller.studentsList.isEmpty) {
                        return const Center(child: Text('No students found'));
                      } else {
                        return ListView.builder(
                          itemCount: controller.studentsList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(controller.studentsList[index]),
                              subtitle: Text(
                                  'Roll Number: ${controller.studentRollNumber[index]}'),
                              trailing: IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  _showEditStudentModal(context, index);
                                },
                              ),
                            );
                          },
                        );
                      }
                    }),
                  )
                : const SizedBox.shrink())
          ],
        ),
      ),
    );
  }

  void _showEditStudentModal(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: EditStudentModal(index: index),
      ),
    );
  }
}

class EditStudentModal extends StatefulWidget {
  final int index;

  const EditStudentModal({super.key, required this.index});

  @override
  State<EditStudentModal> createState() => _EditStudentModalState();
}

final UpdateStudentController controller = Get.find<UpdateStudentController>();

class _EditStudentModalState extends State<EditStudentModal> {
  @override
  void initState() {
    controller.departmentController.text =
        controller.selectedDepartment.value.toString();
    controller.semesterController.text =
        controller.selectedSemester.value.toString();
    controller.nameController.text = controller.studentsList[widget.index];
    controller.rollController.text =
        controller.studentRollNumber[widget.index].toString();
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
            'Edit Student Name',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: controller.departmentController,
            decoration: const InputDecoration(
              labelText: 'Department ID',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: controller.semesterController,
            decoration: const InputDecoration(
              labelText: 'Semester ID',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: controller.nameController,
            decoration: const InputDecoration(
              labelText: 'Student Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          // Textform field for roll number
          TextField(
            controller: controller.rollController,
            decoration: const InputDecoration(
              labelText: 'Roll Number',
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: () async {
              await controller.updatedStudent();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
