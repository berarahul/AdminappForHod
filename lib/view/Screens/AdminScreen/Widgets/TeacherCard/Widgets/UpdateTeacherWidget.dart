import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../viewmodel/service/AdminScreenController/WidgetController/StudentCardServices/update/UpdateStudentController.dart';
import '../../../../../../viewmodel/service/AdminScreenController/WidgetController/TeacherCardServices/update/TeacherUpdateController.dart';

class UpdateTeacherModal extends StatelessWidget {
  final UpdateTeacherController controller = Get.put(UpdateTeacherController());

  UpdateTeacherModal({super.key});

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
              'Update Teacher',
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
              isExpanded: true,
              value: controller.selectedDepartmentId.value,
              onChanged: (newValue) async {
                controller.selectedDepartmentId.value = newValue!;
                // Fetch students only for the selected department
                await  controller.fetchAllTeacher();

              },
              items: controller.departmentIdList.map((department) {
                return DropdownMenuItem<int>(
                  value: department,
                  child: Text(department.toString()),
                );
              }).toList(),
            )),
            const SizedBox(height: 20),
            Obx(() => controller.selectedDepartmentId.value != null
                ? Expanded(
              child: Obx(() {
                if (controller.teacherList.isEmpty) {
                  return const Center(child: Text('No students found'));
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
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: EditTeacherModal(index: index),
      ),
    );
  }
}

class EditTeacherModal extends StatefulWidget {
  final int index;

  const EditTeacherModal({super.key, required this.index});

  @override
  State<EditTeacherModal> createState() => _EditStudentModalState();
}

final UpdateTeacherController controller = Get.find<UpdateTeacherController>();

class _EditStudentModalState extends State<EditTeacherModal> {
  @override
  void initState() {

    controller.nameController.text = controller.teacherList[widget.index];
    controller.teacherIdController.text = controller.teacherId[widget.index].toString();


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
          // Textform field for roll number
          TextField(
            controller: controller.teacherIdController,
            decoration: const InputDecoration(
              labelText: 'Teacher Id',
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 20),
          const Text('New Subjects'),

          Obx(
                () => DropdownSearch<String>.multiSelection(
              items: controller.subjectsList.toList(), // Use fetched subjects
              dropdownBuilder: (context, selectedItems) {
                return Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: selectedItems
                      .map((item) => Chip(label: Text(item)))
                      .toList(),
                );
              },
              popupProps: PopupPropsMultiSelection.menu(
                itemBuilder: (context, item, isSelected) {
                  return ListTile(
                    title: Text(item),
                    selected: isSelected,
                  );
                },
              ),
              onChanged: (List<String> value) {
                controller.fetchallSubjects();
                List<int> selectedIds =
                value.map((String item) => int.parse(item)).toList();
                controller.selectedSubjectIds.value = selectedIds;
              },
              selectedItems: controller.selectedSubjectIds
                  .map((id) => id.toString())
                  .toList(),
            ),
          ),
          const SizedBox(height: 20),

          const SizedBox(height: 20),
          const Text('Remove Subjects'),
          Obx(
                () => DropdownSearch<String>.multiSelection(
              items: controller.subjectsList.toList(), // Use fetched subjects
              dropdownBuilder: (context, selectedItems) {
                return Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: selectedItems
                      .map((item) => Chip(label: Text(item)))
                      .toList(),
                );
              },
              popupProps: PopupPropsMultiSelection.menu(
                itemBuilder: (context, item, isSelected) {
                  return ListTile(
                    title: Text(item),
                    selected: isSelected,
                  );
                },
              ),
              onChanged: (List<String> value) {
                controller.fetchallSubjects();
                List<int> selectedIds =
                value.map((String item) => int.parse(item)).toList();
                controller.selectedSubjectIds.value = selectedIds;
              },
              selectedItems: controller.selectedSubjectIds
                  .map((id) => id.toString())
                  .toList(),
            ),
          ),
          const SizedBox(height: 20),



          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              await controller.updatedTeacher();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}









