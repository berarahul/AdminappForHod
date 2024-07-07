import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../model/departmentModel.dart';
import '../../../../../../viewmodel/service/AdminScreenController/WidgetController/StudentCardServices/last_sem_student_remove/removelastsemController.dart';

class Removestudentfromlastsemwidget extends StatelessWidget {
  final RemoveStudentControllerFromLastSem controller =
      Get.put(RemoveStudentControllerFromLastSem());

  Removestudentfromlastsemwidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Remove Last Semester Students',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              // Obx(() => DropdownButton<int>(
              //     alignment: Alignment.center,
              //     hint: controller.departmentIdList.isEmpty
              //         ? const Center(child: CircularProgressIndicator())
              //         : const Text('Select Department'),
              //     borderRadius: BorderRadius.circular(8),
              //     isExpanded: true,
              //     value: controller.selectedDepartmentId.value,
              //     onChanged: (newValue) async {
              //       // Update the selectedDepartmentId with the new value
              //       controller.selectedDepartmentId.value = newValue!;
              //
              //       await controller.fetchAllStudent();
              //     },
              //     items: controller.departmentIdList.map((departmentId) {
              //       return DropdownMenuItem<int>(
              //         value: departmentId,
              //         child: Text(departmentId.toString()),
              //       );
              //     }).toList())
              //
              // ),

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
                        controller.fetchAllStudent();
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





              Obx(() => controller.students.isEmpty
                  ? const SizedBox()
                  : Row(
                      children: [
                        Obx(() => Checkbox(
                              value: controller.students.length ==
                                  controller.selectedStudent.length,
                              onChanged: (value) {
                                controller.selectAllStudent();
                                controller.selectAllStudentRollNumber();
                              },
                            )),
                        const Text('Select All'),
                      ],
                    )),
              const SizedBox(height: 20),
              Obx(() {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.students.length,
                  itemBuilder: (context, index) {
                    return Obx(
                      () => CheckboxListTile(
                        title: Text(controller.students[index]),
                        value: controller.selectedStudent.contains(controller
                            .students[index]), // Check if the student is selected
                        onChanged: (value) async {
                          controller
                              .toggleSlectedStudent(controller.students[index]);
          
                          controller.toggleSelectedStudentRollNumber(
                              controller.studentRollNumber[index]);
                        },
                      ),
                    );
                  },
                );
              }),
              ElevatedButton(
                onPressed: () async {
                  await controller.removeStudentFromLastSem();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: const Text('Remove Selected Students'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../../../../viewmodel/service/AdminScreenController/WidgetController/StudentCardServices/last_sem_student_remove/removelastsemController.dart';
//
// class Removestudentfromlastsemwidget extends StatelessWidget {
//   final RemoveStudentControllerFromLastSem controller =
//   Get.put(RemoveStudentControllerFromLastSem());
//
//   Removestudentfromlastsemwidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
//       child: SingleChildScrollView(
//         child: Container(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'Remove Last Semester Students',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Obx(() => DropdownButton<int>(
//                 alignment: Alignment.center,
//                 hint: controller.departmentIdList.isEmpty
//                     ? const Center(child: CircularProgressIndicator())
//                     : const Text('Select Department'),
//                 borderRadius: BorderRadius.circular(8),
//                 isExpanded: true,
//                 value: controller.selectedDepartmentId.value,
//                 onChanged: (newValue) async {
//                   // Update the selectedDepartmentId with the new value
//                   controller.selectedDepartmentId.value = newValue!;
//                   await controller.fetchAllStudent();
//                 },
//                 items: controller.departmentIdList.map((departmentId) {
//                   return DropdownMenuItem<int>(
//                     value: departmentId,
//                     child: Text(departmentId.toString()),
//                   );
//                 }).toList(),
//               )),
//               const SizedBox(height: 20),
//               Obx(() => controller.students.isEmpty
//                   ? const SizedBox()
//                   : Row(
//                 children: [
//                   Obx(() => Checkbox(
//                     value: controller.students.length ==
//                         controller.selectedStudent.length,
//                     onChanged: (value) {
//                       controller.selectAllStudent();
//                       controller.selectAllStudentRollNumber();
//                     },
//                   )),
//                   const Text('Select All'),
//                 ],
//               )),
//               const SizedBox(height: 20),
//               Obx(() {
//                 return ListView.builder(
//                   shrinkWrap: true,
//                   itemCount: controller.students.length,
//                   itemBuilder: (context, index) {
//                     return Obx(
//                           () => CheckboxListTile(
//                         title: Text(controller.students[index]),
//                         value: controller.selectedStudent
//                             .contains(controller.students[index]), // Check if the student is selected
//                         onChanged: (value) async {
//                           controller.toggleSlectedStudent(controller.students[index]);
//                           controller.toggleSelectedStudentRollNumber(controller.studentRollNumber[index]);
//                         },
//                       ),
//                     );
//                   },
//                 );
//               }),
//               const SizedBox(height: 20),
//               Center(
//                 child: ElevatedButton(
//                   onPressed: () async {
//                     await controller.removeStudentFromLastSem();
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.red,
//                   ),
//                   child: const Text('Remove Selected Students'),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
