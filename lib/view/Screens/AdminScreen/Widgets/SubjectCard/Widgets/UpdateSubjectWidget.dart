// import 'package:attendanceadmin/model/universalmodel/departmentModel.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../../../../model/subjectCard/papperCodeNameModel.dart';
// import '../../../../../../viewmodel/service/AdminScreenController/WidgetController/StudentCardServices/update/UpdateStudentController.dart';
// import '../../../../../../viewmodel/service/AdminScreenController/WidgetController/SubjectsCardService/update/updateSubjectController.dart';
//
// // Import your actual path
// class UpdateSubjectModal extends StatelessWidget {
//   final Updatesubjectcontroller controller = Get.put(Updatesubjectcontroller());
//   UpdateSubjectModal({super.key}); // Ensure controller is initialized
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding:
//           EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
//       child: Container(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Update Subject',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 20),
//             Obx(() {
//               if (controller.departments.isEmpty) {
//                 return const CircularProgressIndicator();
//               } else {
//                 return DropdownButtonFormField<int>(
//                   items:
//                       controller.departments.map((DepartmentModel department) {
//                     return DropdownMenuItem<int>(
//                       value: department.id,
//                       child: Text(department.departmentName),
//                     );
//                   }).toList(),
//                   onChanged: (value) {
//                     if (value != null) {
//                       controller.setDepartmentId(value);
//                     }
//                   },
//                   decoration: const InputDecoration(
//                     labelText: 'Department',
//                     border: OutlineInputBorder(),
//                   ),
//                   value: controller.departmentId.value == 0
//                       ? null
//                       : controller.departmentId.value,
//                 );
//               }
//             }),
//             const SizedBox(height: 20),
//             Obx(() {
//               // Ensure subjectslistmodel.value and subjectslistmodel.value.subjects are not null
//               var subjectsListModel = controller.subjectslistmodel.value;
//               var subjects = subjectsListModel?.subjects ?? [];
//
//               return Expanded(
//                 child: subjects.isEmpty
//                     ? const Center(child: Text("Currently Subjects are empty"))
//                     : ListView.builder(
//                         itemCount: subjects.length,
//                         itemBuilder: (context, index) {
//                           var subject = subjects[index];
//
//                           return ListTile(
//                             title: Text(subject.subName ?? 'Unknown'),
//                             // Provide a default value for subName if null
//                             trailing: IconButton(
//                               icon: const Icon(Icons.edit),
//                               onPressed: () {
//
//                                 controller.selectedPaperCode.value = subject.paperId ?? 0;
//
//                                 _showEditStudentModal(context, index);
//                               },
//                             ),
//                           );
//                         },
//                       ),
//               );
//             }),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _showEditStudentModal(BuildContext context, int index) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       builder: (context) => Padding(
//         padding:
//             EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
//         child: EditSubjectModal(index: index),
//       ),
//     );
//   }
// }
//
// class EditSubjectModal extends StatefulWidget {
//   final int index;
//
//   const EditSubjectModal({super.key, required this.index});
//
//   @override
//   State<EditSubjectModal> createState() => _EditSubjectModalState();
// }
//
// final Updatesubjectcontroller controller = Get.find<Updatesubjectcontroller>();
//
// class _EditSubjectModalState extends State<EditSubjectModal> {
//   @override
//   void initState() {
//     controller.subjectIdController.text =
//         controller.subjectIds[widget.index].toString();
//
//     controller.subjectNameController.text =
//         controller.subjectNames[widget.index];
//     controller.departmentIdController.text =
//         controller.departmentId.value.toString();
//     controller.semesterIdController.text =
//         controller.semesterIds[widget.index].toString();
//
//     controller.paperNameController.text=controller.paperNames[widget.index];
//
//     controller.selectedPaperCode.value = controller.paperIds[widget.index];
//
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Edit Subject Details',
//             style: TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 20),
//           // TextField(
//           //   controller: controller.subjectIdController,
//           //   decoration: const InputDecoration(
//           //     labelText: 'Subject ID',
//           //     border: OutlineInputBorder(),
//           //   ),
//           // ),
//           const SizedBox(height: 20),
//           TextField(
//             controller: controller.subjectNameController,
//             decoration: const InputDecoration(
//               labelText: 'Name',
//               border: OutlineInputBorder(),
//             ),
//           ),
//           const SizedBox(height: 20),
//           TextField(
//             controller: controller.departmentIdController,
//             decoration: const InputDecoration(
//               labelText: 'Department Id',
//               enabled: false,
//               border: OutlineInputBorder(),
//             ),
//           ),
//           const SizedBox(height: 20),
//           // Textform field for roll number
//           TextField(
//             controller: controller.semesterIdController,
//             decoration: const InputDecoration(
//               labelText: 'Semester Id',
//               border: OutlineInputBorder(),
//             ),
//           ),
//           const SizedBox(height: 20),
//           Obx(() {
//             if (controller.PaperCodeName.isEmpty) {
//               return const CircularProgressIndicator();
//             } else {
//               return DropdownButtonFormField<int>(
//                 items: controller.PaperCodeName.map((PaperCodeNameModel paperCodeName) {
//                   return DropdownMenuItem<int>(
//                     value: paperCodeName.id,
//                     child: Text(paperCodeName.subjectIdName),
//                   );
//                 }).toList(),
//                 onChanged: (value) {
//                   if (value != null) {
//                     controller.setPaperCodeNameId(value);
//                   }
//                 },
//                 decoration: const InputDecoration(
//                   labelText: 'Paper Code Name',
//                   border: OutlineInputBorder(),
//                 ),
//                 value: controller.PaperCodeNameId.value == 0
//                     ? null
//                     : controller.PaperCodeNameId.value,
//               );
//             }
//           }),
//
//
//
//           const SizedBox(height: 20),
//
//           ElevatedButton(
//             onPressed: () async {
//               await controller.updatedSubject();
//             },
//             child: const Text('Save'),
//           ),
//         ],
//       ),
//     );
//   }
// }



import 'package:attendanceadmin/model/universalmodel/departmentModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../model/subjectCard/papperCodeNameModel.dart';
import '../../../../../../viewmodel/service/AdminScreenController/WidgetController/StudentCardServices/update/UpdateStudentController.dart';
import '../../../../../../viewmodel/service/AdminScreenController/WidgetController/SubjectsCardService/update/updateSubjectController.dart';

// Import your actual path
class UpdateSubjectModal extends StatelessWidget {
  final Updatesubjectcontroller controller = Get.put(Updatesubjectcontroller());
  UpdateSubjectModal({super.key}); // Ensure controller is initialized
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Update Subject',
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
                  items:
                  controller.departments.map((DepartmentModel department) {
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
            Obx(() {
              // Ensure subjectslistmodel.value and subjectslistmodel.value.subjects are not null
              var subjectsListModel = controller.subjectslistmodel.value;
              var subjects = subjectsListModel?.subjects ?? [];

              return Expanded(
                child: subjects.isEmpty
                    ? const Center(child: Text("Currently Subjects are empty"))
                    : ListView.builder(
                  itemCount: subjects.length,
                  itemBuilder: (context, index) {
                    var subject = subjects[index];

                    return ListTile(
                      title: Text(subject.subName ?? 'Unknown'),
                      // Provide a default value for subName if null
                      trailing: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {

                          controller.PaperCodeNameId.value = subject.paperId!;
                          _showEditStudentModal(context, index);
                        },
                      ),
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  void _showEditStudentModal(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding:
        EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: EditSubjectModal(index: index),
      ),
    );
  }
}

class EditSubjectModal extends StatefulWidget {
  final int index;

  const EditSubjectModal({super.key, required this.index});

  @override
  State<EditSubjectModal> createState() => _EditSubjectModalState();
}

final Updatesubjectcontroller controller = Get.find<Updatesubjectcontroller>();

class _EditSubjectModalState extends State<EditSubjectModal> {
  late int originalSubjectId;
  late String originalSubjectName;
  late int originalDepartmentId;
  late int originalSemesterId;
  late String originalPaperName;
  late int originalPaperCodeId;

  @override
  void initState() {
    super.initState();
    originalSubjectId = controller.subjectIds[widget.index];
    originalSubjectName = controller.subjectNames[widget.index];
    originalDepartmentId = controller.departmentId.value;
    originalSemesterId = controller.semesterIds[widget.index];
    originalPaperName = controller.paperNames[widget.index];
    originalPaperCodeId = controller.paperIds[widget.index];

    controller.subjectIdController.text = originalSubjectId.toString();
    controller.subjectNameController.text = originalSubjectName;
    controller.departmentIdController.text = originalDepartmentId.toString();
    controller.semesterIdController.text = originalSemesterId.toString();
    controller.paperNameController.text = originalPaperName;
    controller.selectedPaperCode.value = originalPaperCodeId;
  }

  bool hasChanges() {
    return controller.subjectNameController.text != originalSubjectName ||
        controller.departmentIdController.text != originalDepartmentId.toString() ||
        controller.semesterIdController.text != originalSemesterId.toString() ||
        controller.selectedPaperCode.value != originalPaperCodeId;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Edit Subject Details',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: controller.subjectNameController,
            decoration: const InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: controller.departmentIdController,
            decoration: const InputDecoration(
              labelText: 'Department Id',
              enabled: false,
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: controller.semesterIdController,
            decoration: const InputDecoration(
              labelText: 'Semester Id',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          Obx(() {
            if (controller.PaperCodeName.isEmpty) {
              return const CircularProgressIndicator();
            } else {
              return DropdownButtonFormField<int>(
                items: controller.PaperCodeName.map((PaperCodeNameModel paperCodeName) {
                  return DropdownMenuItem<int>(
                    value: paperCodeName.id,
                    child: Text(paperCodeName.subjectIdName),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    controller.setPaperCodeNameId(value);
                  }
                },
                decoration: const InputDecoration(
                  labelText: 'Paper Code Name',
                  border: OutlineInputBorder(),
                ),
                value: controller.selectedPaperCode.value == 0
                    ? null
                    : controller.selectedPaperCode.value,
              );
            }
          }),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: Colors.blue, // Set the color of the text here
            ),
            onPressed: () async {
              if (hasChanges()) {
                await controller.updatedSubject();
              } else {
                Get.snackbar("No Changes", "No changes detected to update");
              }
            },
            child: const Center(child: Text('Save')),
          ),
        ],
      ),
    );
  }
}
