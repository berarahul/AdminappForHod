import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dropdown_search/dropdown_search.dart';
import '../../../../../../constant/AppColors.dart';
import '../../../../../../model/departmentModel.dart';
import '../../../../../../viewmodel/service/AdminScreenController/WidgetController/TeacherCardServices/add/TeacherAddController.dart';

class AddTeacherModal extends StatelessWidget {
  final AddTeacherController controller = Get.put(AddTeacherController());

  AddTeacherModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Add Teacher',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              onChanged: (value) {
                controller.setTeacherName(value);
              },
              decoration: const InputDecoration(
                labelText: 'Teacher Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              onChanged: (value) {
                controller.userName(value);
              },
              decoration: const InputDecoration(
                labelText: 'User Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              onChanged: (value) {
                controller.password(value);
              },
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              onChanged: (value) {
                controller.confirmPassword(value);
              },
              decoration: const InputDecoration(
                labelText: 'Confirm Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 20),
            const SizedBox(height: 20),
            // Obx(() => DropdownButton<int>(
            //     alignment: Alignment.center,
            //     hint: controller.departmentIdList.isEmpty
            //         ? const Center(child: CircularProgressIndicator())
            //         : const Text('Select Department'),
            //     borderRadius: BorderRadius.circular(8),
            //     isExpanded: true,
            //     value: controller.selectedDepartmentId.value,
            //     onChanged: (newValue) async {
            //       // Update the selectedDepartmentId with the new value
            //       controller.selectedDepartmentId.value = newValue!;
            //
            //       await controller.fetchallSubjects();
            //     },
            //     items: controller.departmentIdList.map((departmentId) {
            //       return DropdownMenuItem<int>(
            //         value: departmentId,
            //         child: Text(departmentId.toString()),
            //       );
            //     }).toList())),


            Obx(() {
              if (controller.departments.isEmpty) {
                return const CircularProgressIndicator();
              } else {
                return DropdownButtonFormField<int>(
                  items: controller.departments.map((DepartmentModel department) {
                    return DropdownMenuItem<int>(
                      value: department.id,
                      child: Text(department.departmentName),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      controller.setDepartmentId(value);
                      controller.subjectsList.clear();
                      controller.fetchallSubjects();
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
            const Text('Add Subjects'),
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
            ElevatedButton(
              onPressed: () async => await controller.submit(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.appcolor, // Background color
              ),
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
