import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dropdown_search/dropdown_search.dart';
import '../../../../../../constant/AppColors.dart';
import '../../../../../../model/subjectCard/papperCodeNameModel.dart';
import '../../../../../../model/universalmodel/departmentModel.dart';
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
                controller.subjectName(value);
              },
              decoration: const InputDecoration(
                labelText: 'Subject Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            const SizedBox(height: 20),

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
            // TextField(
            //   keyboardType: TextInputType.number,
            //   textInputAction: TextInputAction.next,
            //   onChanged: (value) {
            //
            //     int? intValue = int.tryParse(value);
            //     // Update the controller's semesterId with the parsed int value
            //     controller.semesterId.value = intValue;
            //
            //   },
            //   decoration: const InputDecoration(
            //     labelText: 'Semester id',
            //     border: OutlineInputBorder(),
            //   ),
            // ),


            DropdownButtonFormField<int>(
              items: List.generate(6, (index) => index + 1).map((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(value.toString()),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  controller.semesterId.value = value;
                }
              },
              decoration: const InputDecoration(
                labelText: 'Semester ID',
                border: OutlineInputBorder(),
              ),
              value: controller.semesterId.value == 0
                  ? null
                  : controller.semesterId.value,
            ),



            const SizedBox(height: 20),

            Obx(() {
              if (controller.PaperCodeName.isEmpty) {
                return const CircularProgressIndicator();
              } else {
                return DropdownButtonFormField<int>(
                  items: controller.PaperCodeName.map((PaperCodeNameModel paperCodeName) {
                    return DropdownMenuItem<int>(
                      value: paperCodeName.id,
                      child: Text(paperCodeName.subjectIdName),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      controller.setPaperCodeNameId(value);
                    }
                  },
                  decoration: const InputDecoration(
                    labelText: 'Paper Code Name',
                    border: OutlineInputBorder(),
                  ),
                  value: controller.PaperCodeNameId.value == 0
                      ? null
                      : controller.PaperCodeNameId.value,
                );
              }
            }),





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
