import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../constant/AppColors.dart';
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
              labelText: 'Roll Num',
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
            textInputAction: TextInputAction.next,
            onChanged: (value) {
              controller.setDepartmentId(int.parse(value));
            },
            decoration: const InputDecoration(
              labelText: 'Department ID',
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
              labelText: 'Semester ID',
              border: OutlineInputBorder(),
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
    );
  }
}
