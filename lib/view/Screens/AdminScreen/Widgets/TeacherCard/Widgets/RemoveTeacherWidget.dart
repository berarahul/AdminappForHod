import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../viewmodel/service/AdminScreenController/WidgetController/SubjectsCardService/remove/removesubjectController.dart';
import '../../../../../../viewmodel/service/AdminScreenController/WidgetController/TeacherCardServices/remove/TeacherremoveController.dart';

class RemoveTeacherScreen extends StatelessWidget {
  final RemoveTeacherController controller = Get.put(RemoveTeacherController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Remove Teacher'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<int>(
              value: controller.selectedSemester.value == 0 ? null : controller.selectedSemester.value,
              items: [1, 2, 3].map((semester) {
                return DropdownMenuItem<int>(
                  value: semester,
                  child: Text('Semester $semester'),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  controller.selectedSemester.value = value;
                }
              },
              decoration: const InputDecoration(
                labelText: 'Select Semester',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Obx(() {
              final teacher = controller.filteredTeachers;
              return ListView.builder(
                shrinkWrap: true,
                itemCount: teacher.length,
                itemBuilder: (context, index) {
                  final Teacher = teacher[index];
                  return ListTile(
                    title: Text(Teacher.name),
                    subtitle: Text('Semester ${Teacher.semesterId}'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        controller.removeTeachers(Teacher.id);
                      },
                    ),
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
