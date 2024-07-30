import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../constant/AppColors.dart';
import '../../../../../../model/universalmodel/departmentModel.dart';
import '../../../../../../viewmodel/service/AdminScreenController/WidgetController/StudentCardServices/add/AddStudentWidgetController.dart';

class AddStudentModal extends StatelessWidget {
  final AddStudentController controller = Get.put(AddStudentController());

  AddStudentModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Add Student',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,
            onChanged: (value) {
              controller.setStudentName(value);
            },
            decoration: const InputDecoration(
              labelText: 'Student Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            onChanged: (value) {
              controller.setRollNum(int.parse(value));
            },
            decoration: const InputDecoration(
              labelText: 'Roll',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            onChanged: (value) {
              controller.setStudentId(value);
            },
            decoration: const InputDecoration(
              labelText: 'Student ID',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
            onChanged: (value) {
              controller.setSemesterId(int.parse(value));
            },
            decoration: const InputDecoration(
              labelText: 'Semester',
              border: OutlineInputBorder(),
            ),
          ),
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
          ElevatedButton(
            onPressed: () async {
              await controller.submit();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.appcolor, // Background color
            ),
            child: const Center(child: Text('Submit',style: TextStyle(color: Colors.white),),),
          ),
        ],
      ),
    );
  }
}
