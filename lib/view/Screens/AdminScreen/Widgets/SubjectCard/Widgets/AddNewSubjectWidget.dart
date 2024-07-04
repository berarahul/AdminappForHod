import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../constant/AppColors.dart';
import '../../../../../../viewmodel/service/AdminScreenController/WidgetController/SubjectsCardService/add/AddNewSubjectController.dart';

class AddSubjectModel extends StatelessWidget {
  final Addnewsubjectcontroller controller = Get.put(Addnewsubjectcontroller());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
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
          DropdownButtonFormField<int>(
            value: controller.selectedSemester.value,
            items: [
              DropdownMenuItem<int>(
                value: 1,
                child: Text('Semester 1'),
              ),
              DropdownMenuItem<int>(
                value: 2,
                child: Text('Semester 2'),
              ),
              DropdownMenuItem<int>(
                value: 3,
                child: Text('Semester 3'),
              ),
            ],
            onChanged: (value) {
              controller.selectedSemester.value = value!;
            },
            decoration: InputDecoration(
              labelText: 'Select Semester',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            onChanged: (value) {
              controller.setSubjectName(value);
            },
            decoration: InputDecoration(
              labelText: 'Subject Name',
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
