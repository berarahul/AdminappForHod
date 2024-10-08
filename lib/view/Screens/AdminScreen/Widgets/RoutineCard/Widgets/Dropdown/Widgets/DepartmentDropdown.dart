import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../../../model/universalmodel/departmentModel.dart';
import '../../../../../../../../viewmodel/service/AdminScreenController/WidgetController/RoutineCardServices/Dropdown/DepartmentController.dart';
import '../../../../../../../../viewmodel/service/AdminScreenController/WidgetController/StudentCardServices/semesterEdit/SemesterEditController.dart';


class DepartmentDropdown extends StatelessWidget {
  final DepartmentController departmentController = Get.put(DepartmentController());
  final SemesterController semesterController = Get.put(SemesterController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (departmentController.isLoading.value) {
        return CircularProgressIndicator();
      } else {
        return DropdownButtonFormField<DepartmentModel?>(
          value: departmentController.departmentList.firstWhereOrNull(
                (department) => department.id == departmentController.selectedDepartmentId.value,
          ),
          items: departmentController.departmentList.map((department) {
            return DropdownMenuItem<DepartmentModel>(
              value: department,
              child: Text(department.departmentName),
            );
          }).toList(),
          onChanged: (DepartmentModel? newValue) {
            if (newValue != null) {
              departmentController.selectDepartment(newValue.id);
            }
          },
          decoration: InputDecoration(
            hintStyle: TextStyle(color: Colors.black),
            hintText: 'Select department',
            // labelText: 'Select Department',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            filled: true,
            fillColor: Colors.grey.shade200,
          ),
          dropdownColor: Colors.white,
          icon: Icon(Icons.arrow_drop_down,color: Colors.black,),
          iconSize: 30,
          style: TextStyle(color: Colors.black, fontSize: 16),
          isExpanded: true,
        );
      }
    });
  }
}
