import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dropdown_search/dropdown_search.dart';
import '../../../../../../constant/AppColors.dart';
import '../../../../../../viewmodel/service/AdminScreenController/WidgetController/SubjectsCardService/add/AddNewSubjectController.dart';
import '../../../../../../viewmodel/service/AdminScreenController/WidgetController/TeacherCardServices/add/TeacherAddController.dart';

class AddSubjectModal extends StatelessWidget {
  final AddSubjectController controller = Get.put(AddSubjectController());

  AddSubjectModal({super.key});

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
              'Add Subject',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
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
                labelText: 'Subject Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),




            const SizedBox(height: 20),
            Obx(() => DropdownButton<int>(
                alignment: Alignment.center,
                hint: controller.departmentIdList.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : const Text('Select Department'),
                borderRadius: BorderRadius.circular(8),
                isExpanded: true,
                value: controller.selectedDepartmentId.value,
                onChanged: (newValue) async {
                  // Update the selectedDepartmentId with the new value
                  controller.selectedDepartmentId.value = newValue!;

                  await controller.fetchallSubjects();
                },
                items: controller.departmentIdList.map((departmentId) {
                  return DropdownMenuItem<int>(
                    value: departmentId,
                    child: Text(departmentId.toString()),
                  );
                }).toList())
            ),
            const SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              onChanged: (value) {
                controller.userName(value);
              },
              decoration: const InputDecoration(
                labelText: 'Semester id',
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
                labelText: 'Subject id',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),


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
