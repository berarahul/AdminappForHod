import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../model/departmentModel.dart';
import '../../../../../../viewmodel/service/AdminScreenController/WidgetController/StudentCardServices/semesterEdit/SemesterEditController.dart';
import '../../SubjectCard/Widgets/UpdateSubjectWidget.dart';

class AddSemesterScreen extends StatelessWidget {
  final SemesterController semesterController = Get.put(SemesterController());
  AddSemesterScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Student by Semester'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Obx(
            //       () => DropdownButton<int>(
            //     alignment: Alignment.center,
            //     hint: semesterController.departmentIdList.isEmpty
            //         ? const Center(child: CircularProgressIndicator())
            //         : const Text('Select Department'),
            //     borderRadius: BorderRadius.circular(8),
            //     isExpanded: true,
            //     value: semesterController.selectedDepartmentId.value,
            //     onChanged: (newValue) async {
            //       // Update the selectedDepartmentId with the new value
            //       semesterController.selectedDepartmentId.value = newValue!;
            //     },
            //     items: semesterController.departmentIdList.map((departmentId) {
            //       return DropdownMenuItem<int>(
            //         value: departmentId,
            //         child: Text(departmentId.toString()),
            //       );
            //     }).toList(),
            //   ),
            // ),



            Obx(() {
              if (semesterController.departments.isEmpty) {
                return const CircularProgressIndicator();
              } else {
                return DropdownButtonFormField<int>(
                  items: semesterController.departments.map((DepartmentModel department) {
                    return DropdownMenuItem<int>(
                      value: department.id,
                      child: Text(department.departmentName),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      semesterController.setDepartmentId(value);
                    }
                  },
                  decoration: const InputDecoration(
                    labelText: 'Department',
                    border: OutlineInputBorder(),
                  ),
                  value: semesterController.departmentId.value == 0
                      ? null
                      : semesterController.departmentId.value,
                );
              }
            }),


            const SizedBox(height: 20),
            Obx(
                  () => DropdownButton<int>(
                alignment: Alignment.center,
                hint: const Text('Select Semester Number'),
                borderRadius: BorderRadius.circular(8),
                isExpanded: true,
                value: semesterController.selectedSemesterNumber.value,
                onChanged: (newValue) {
                  semesterController.selectedSemesterNumber.value = newValue!;
                  semesterController.semesterNameController.text = newValue.toString();
                },
                items: semesterController.semesterNumberList.map((semesterNumber) {
                  return DropdownMenuItem<int>(
                    value: semesterNumber,
                    child: Text(semesterNumber.toString()),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                print("Calling...");
                semesterController.addSemester();
                print("fetch success");
                Get.snackbar('Student Transfer', "Student Transfer from your input semester to next semester");
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
