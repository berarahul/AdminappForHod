import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../constant/AppColors.dart';
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
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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

                // Dropdown for selecting department id
                Obx(() {
                  return DropdownButton<int>(
                      alignment: Alignment.center,
                      hint: controller.departmentIdList.isEmpty
                          ? const Center(child: CircularProgressIndicator())
                          : const Text('Select Department'),
                      borderRadius: BorderRadius.circular(8),
                      isExpanded: true,
                      value: controller.selectedDepartmentId.value,
                      onChanged: (newValue) {
                        // Update the selectedDepartmentId with the new value
                        controller.selectedDepartmentId.value = newValue!;

                        // Fetch all the teachers of the selected department

                        controller.fetchAllTeachers();
                      },
                      items: controller.departmentIdList.map((departmentId) {
                        return DropdownMenuItem<int>(
                          value: departmentId,
                          child: Text(departmentId.toString()),
                        );
                      }).toList());
                }),

                const SizedBox(height: 20),
                Obx(() {
                  if (controller.selectedDepartmentId.value == null) {
                    return Container();
                  } else {
                    return Expanded(
                      child: Column(
                        children: [
                          TextField(
                            onChanged: (value) {},
                            decoration: const InputDecoration(
                              labelText: 'Search Teacher',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 20),
                          //Todo: Need to impl this
                          // Row(
                          //   children: [
                          //     Checkbox(
                          //       value: false,
                          //       onChanged: (value) {
                          //         controller.selectAllStudents(value!);
                          //       },
                          //     ),
                          //     const Text('Select All'),
                          //   ],
                          // ),
                          // const SizedBox(height: 20),
                          Obx(() {
                            return Expanded(
                              child: controller.teachersList.isEmpty
                                  ? const Center(
                                      child: CircularProgressIndicator())
                                  : ListView.builder(
                                      itemCount: controller.teachersList.length,
                                      itemBuilder: (context, index) {
                                        return Obx(() => ListTile(
                                              title: Text(
                                                controller.teachersList[index]
                                                    ['name'],
                                              ),
                                              subtitle: Text(
                                                  "Teacher ID: ${controller.teachersList[index]['teacherId']}"),
                                              trailing: Obx(() => Checkbox(
                                                    value: controller
                                                            .selectedTeacher
                                                            .value ==
                                                        controller.teachersList[
                                                            index]['teacherId'],
                                                    onChanged: (value) {
                                                      controller.toogleSelectAndUnselect(
                                                          teacherId: controller
                                                                  .teachersList[
                                                              index]['teacherId']);
                                                    },
                                                  )),
                                            ));
                                      },
                                    ),
                            );
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
                            child: const Text('Remove Selected Students'),
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
