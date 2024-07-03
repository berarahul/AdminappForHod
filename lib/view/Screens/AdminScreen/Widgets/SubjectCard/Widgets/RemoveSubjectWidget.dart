import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../viewmodel/service/AdminScreenController/WidgetController/SubjectsCardService/remove/removesubjectController.dart';

class RemoveSubjectScreen extends StatelessWidget {
  final RemoveSubjectController controller = Get.put(RemoveSubjectController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Remove Subject'),
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
              final subjects = controller.filteredSubjects;
              return ListView.builder(
                shrinkWrap: true,
                itemCount: subjects.length,
                itemBuilder: (context, index) {
                  final subject = subjects[index];
                  return ListTile(
                    title: Text(subject.name),
                    subtitle: Text('Semester ${subject.semesterId}'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        controller.removeSubject(subject.id);
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
