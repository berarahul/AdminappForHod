import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../constant/AppColors.dart';
import '../../../../../../model/universalmodel/departmentModel.dart';
import '../../../../../../viewmodel/service/AdminScreenController/WidgetController/StudentCardServices/remove/RemoveStudentController.dart';
import '../../../../../../viewmodel/service/AdminScreenController/WidgetController/SubjectsCardService/remove/removesubjectController.dart';
import '../../StudentCard/Widgets/UpdateStudentWidget.dart';

class RemoveSubjectModal extends StatelessWidget {
  final RemoveSubjectController controller = Get.put(RemoveSubjectController());

  RemoveSubjectModal({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Remove Subject',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),

                Obx(() {
                  if (controller.departments.isEmpty) {
                    return const CircularProgressIndicator();
                  } else {
                    return DropdownButtonFormField<int>(
                      items: controller.departments
                          .map((DepartmentModel department) {
                        return DropdownMenuItem<int>(
                          value: department.id,
                          child: Text(department.departmentName),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          controller.setDepartmentId(value);
                          print("fetching subject");
                          controller.fetchAllSubject();
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
                Obx(() {
                  if (controller.departmentId.value == null) {
                    return Container();
                  } else {
                    return Expanded(
                      child: Column(
                        children: [
                          Obx(() {
                            return Expanded(
                                child: controller.subjects.isEmpty
                                    ? const Center(
                                    child: Text("Currently Subjects are not Showing"))
                                    : ListView.builder(
                                  itemCount: controller.subjects.length,
                                  itemBuilder: (context, index) {
                                    return Obx(() {
                                      return CheckboxListTile(
                                        value: controller.selectedSubject
                                            .contains(
                                          controller
                                              .subjectId[index],
                                        ),
                                        onChanged: (value) {
                                          controller.toggleIsUserSelected(
                                            index: index,
                                          );
                                        },
                                        title: Text(
                                            controller.subjects[index]),
                                      );
                                    });
                                  },
                                ));
                          }

                          ),

                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () async {

                              await controller.removeSelectedSubjects();
                              await controller.updateList();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            child: const Text('Remove Selected Subjects'),
                          ),
                        ],
                      ),
                    );
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
