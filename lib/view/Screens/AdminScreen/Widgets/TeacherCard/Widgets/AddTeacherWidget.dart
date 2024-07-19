import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:multi_select_flutter/dialog/mult_select_dialog.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import '../../../../../../constant/AppColors.dart';
import '../../../../../../model/subjectCard/subjectsListModel.dart';
import '../../../../../../model/universalmodel/departmentModel.dart';
import '../../../../../../viewmodel/service/AdminScreenController/WidgetController/TeacherCardServices/add/TeacherAddController.dart';
import '../../StudentCard/Widgets/UpdateStudentWidget.dart';

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


            Obx(() {
              if (controller.departments.isEmpty) {
                return const CircularProgressIndicator();
              } else {
                return DropdownButtonFormField<int>(
                  items: controller.departments.map((
                      DepartmentModel department) {
                    return DropdownMenuItem<int>(
                      value: department.id,
                      child: Text(department.departmentName),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      controller.setDepartmentId(value);
                      controller.subjectsList.clear();
                      controller.fetchsubjects();
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
            ElevatedButton(
              onPressed: () {
                controller.fetchsubjects();
                _showSubjectsDialog(context);
              },
              child: const Text('Select Subjects'),
            ),
            const SizedBox(height: 20),


            ElevatedButton(
              onPressed: () async => await controller.submit(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.appcolor, // Background color
              ),
              child: const Text('Submit',style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
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
            title: Text('Select Subjects'),
            backgroundColor: Colors.white,
            items: controller.subjects
                .map((subject) =>
                MultiSelectItem(
                  subject,
                  subject.subName!,
                ))
                .toList(),
            initialValue: controller.selectedSubjects.toList(),
            onConfirm: (values) {
              // Update selected subjects
              controller.selectedSubjects.assignAll(
                  values.cast<SubjectModel>());
              print('Selected Subjects: ${controller.selectedSubjects.map((
                  subject) => subject.id).toList()}');
              // Dismiss dialog
              // Navigator.pop(context); // Close the dialog
            },
          );
        },
      );
    });
  }
}