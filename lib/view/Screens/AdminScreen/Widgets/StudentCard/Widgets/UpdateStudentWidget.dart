import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../model/universalmodel/departmentModel.dart';
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



            Obx(() {
              return DropdownButtonFormField<int>(
                items: controller.semestersList
                    .map((semester) {
                  return DropdownMenuItem<int>(
                    value: semester,
                    child: Text(semester.toString()),
                  );
                }).toList(),
                onChanged: (newValue) {
                  if (newValue != null) {
                    controller.selectedSemester.value = newValue;
                    print(newValue);
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
            //
            Obx(() => controller.departmentId.value != null &&
                    controller.selectedSemester.value != null
                ? Expanded(
                    child: Obx(() {
                      print("i am inside the obx");
                      if (controller.studentsList.isEmpty) {
                        return const Center(child: Text('No students found'));
                      } else {
                        print("hi i am here");
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
        controller.departmentId.value.toString();
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
            enabled: false,
            controller: controller.departmentController,
            decoration: const InputDecoration(
              labelText: 'Department ID',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            enabled: false,
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
            enabled: false,
            controller: controller.rollController,
            decoration: const InputDecoration(
              labelText: 'Roll Number',
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 20),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: Colors.blue, // Set the color of the text here
            ),
            onPressed: () async {
              await controller.updatedStudent();
            },
            child: const Center(child: Text('Save',style: TextStyle(color: Colors.white),)),
          ),
        ],
      ),
    );
  }
}
