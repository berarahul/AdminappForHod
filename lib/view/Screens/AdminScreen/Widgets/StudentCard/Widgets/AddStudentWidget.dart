import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../constant/AppColors.dart';
import '../../../../../../viewmodel/service/AdminScreenController/WidgetController/StudentCardServices/AddStudentWidgetController.dart';

class AddStudentModal extends StatelessWidget {
  final AddStudentController controller = Get.put(AddStudentController());

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
            onChanged: (value) {
              controller.setStudentName(value);
            },
            decoration: InputDecoration(
              labelText: 'Student Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              controller.submit();
            },
            child: const Text('Submit'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.appcolor, // Background color
            ),
          ),
        ],
      ),
    );
  }
}
