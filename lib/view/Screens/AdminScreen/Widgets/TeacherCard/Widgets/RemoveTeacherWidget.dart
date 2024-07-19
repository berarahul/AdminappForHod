import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../constant/AppColors.dart';
import '../../../../../../model/universalmodel/departmentModel.dart';
import '../../../../../../viewmodel/service/AdminScreenController/WidgetController/StudentCardServices/remove/RemoveStudentController.dart';
import '../../../../../../viewmodel/service/AdminScreenController/WidgetController/TeacherCardServices/remove/TeacherremoveController.dart';

class RemoveTeacherModel extends StatelessWidget {
  final RemoveTeacherController controller = Get.put(RemoveTeacherController());

  RemoveTeacherModel({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Remove Teacher',
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
                          controller.departmentId(value);
                          print("fetching Subjects");
                          controller.fetchAllTeachers();
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
                              child: controller.teachersList.isEmpty
                                  ? const Center(
                                child: CircularProgressIndicator(),
                              )
                                  : ListView.builder(
                                shrinkWrap: true,
                                itemCount: controller.teachersList.length,
                                itemBuilder: (context, index) {
                                  return Obx(() => ListTile(
                                    title: Text(
                                      controller.teachersList[index]
                                      ['name'],
                                    ),
                                    subtitle: Text(
                                      "Teacher ID: ${controller.teachersList[index]['teacherId']}",
                                    ),
                                    trailing: Obx(() => Checkbox(
                                      value: controller
                                          .selectedTeacher
                                          .value ==
                                          controller.teachersList[
                                          index]['teacherId'],
                                      onChanged: (value) {
                                        controller
                                            .toogleSelectAndUnselect(
                                            teacherId: controller
                                                .teachersList[
                                            index]
                                            ['teacherId']);
                                      },
                                    )),
                                  ));
                                },
                              ),
                            );
                          }),
                        ],
                      ),
                    );
                  }
                }),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    await controller.removeSelectedTeachers();
                    await controller.updateList();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text('Remove Selected Teacher'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
