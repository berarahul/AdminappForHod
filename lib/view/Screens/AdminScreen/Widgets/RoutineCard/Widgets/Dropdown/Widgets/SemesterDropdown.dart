// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../../../../../../viewmodel/service/AdminScreenController/WidgetController/RoutineCardServices/Dropdown/SemesterController.dart';
// import '../../../../../../../../viewmodel/service/AdminScreenController/WidgetController/StudentCardServices/semesterEdit/SemesterEditController.dart';
//
//
// class SemesterDropdown extends StatelessWidget {
//   final SemesterControllerD semesterController = Get.find();
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       return DropdownButtonFormField<int>(
//         value: semesterController.selectedSemesterId.value == 0
//             ? null
//             : semesterController.selectedSemesterId.value,
//         decoration: InputDecoration(
//           hintStyle: TextStyle(color: Colors.black),
//           hintText: 'Select Semester',
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//           contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//           filled: true,
//           fillColor: Colors.grey.shade200,
//         ),
//         items: semesterController.semesterList.map((semester) {
//           return DropdownMenuItem<int>(
//             value: semester.id,
//             child: Text(
//               semester.semesterName,
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//             ),
//           );
//         }).toList(),
//         onChanged: (value) {
//           if (value != null) {
//             semesterController.selectSemester(value);
//           }
//         },
//         dropdownColor: Colors.white,
//         icon: Icon(Icons.arrow_drop_down),
//         iconSize: 30,
//         style: TextStyle(color: Colors.black, fontSize: 16),
//         isExpanded: true,
//       );
//     });
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../../viewmodel/service/AdminScreenController/WidgetController/RoutineCardServices/Dropdown/SemesterController.dart';
import '../../../../../../../../viewmodel/service/AdminScreenController/WidgetController/StudentCardServices/semesterEdit/SemesterEditController.dart';

class SemesterDropdown extends StatelessWidget {
  final SemesterControllerD semesterController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return DropdownButtonFormField<int>(
        value: semesterController.selectedSemesterId.value == 0
            ? null
            : semesterController.selectedSemesterId.value,
        decoration: InputDecoration(
          hintText: 'Select Semester',
          hintStyle: TextStyle(color: Colors.black, fontSize: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          filled: true,
          fillColor: Colors.grey.shade200,
        ),
        items: semesterController.semesterList.map((semester) {
          return DropdownMenuItem<int>(
            value: semester.id,
            child: Text(
              semester.semesterName,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          );
        }).toList(),
        onChanged: (value) {
          if (value != null) {
            semesterController.selectSemester(value);
          }
        },
        dropdownColor: Colors.white,
        icon: Icon(Icons.arrow_drop_down,color: Colors.black,),
        iconSize: 30,
        style: TextStyle(color: Colors.black, fontSize: 16),
        isExpanded: true,
      );
    });
  }
}
