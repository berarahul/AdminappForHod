import 'package:attendanceadmin/model/RoutineModel/RoutineModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../../model/subjectCard/subjectsListModel.dart';
import '../../../../../../model/universalmodel/departmentModel.dart';
import '../../../../../../viewmodel/service/AdminScreenController/WidgetController/RoutineCardServices/AddClass/AddClassWidgetController.dart';

class AddClassScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AddClassController controller = Get.put(AddClassController());
    final RxBool isLoading = false.obs;

    // Validator function to check room name format
    String? validateRoomName(String? value) {
      if (value == null || value.isEmpty) {
        return 'Room Name is required';
      }
      // Prefixes to check
      final prefixes = ['RN', 'VS', 'PC'];
      // Regular expression to match the format
      final roomNamePattern = RegExp(r'^(' + prefixes.join('|') + r')-\d{3}$');

      if (!roomNamePattern.hasMatch(value)) {
        return 'Room Name must start with RN, VS, or PC followed by a hyphen and a 3-digit number';
      }
      return null;
    }


    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Add Class'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FormBuilder(
            key: controller.formKey,
            child: Column(
              children: [
                const SizedBox(height: 20,),

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
                          print("subjects Fetching");
                          controller.fetchSubjects();
                          print("fetching Teachers");
                          controller.fetchTeachers();
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

                const SizedBox(height: 20,),

                Obx(() {
                  if (controller.subjects.isEmpty) {
                    return Container();
                  } else {
                    return DropdownButtonFormField<int>(
                      items: controller.subjects.map((SubjectModel subject) {
                        return DropdownMenuItem<int>(
                          value: subject.id,
                          child: Container(
                            width: 200, // Adjust the width as needed
                            child: Text(
                              subject.subName ?? 'Unknown',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          final selectedSubject = controller.subjects.firstWhere(
                                (subject) => subject.id == value,
                            orElse: () => SubjectModel(subName: 'Unknown'),
                          );

                          controller.setSubjectId(value);

                          Get.snackbar(
                            'Selected Subject',
                            selectedSubject.subName ?? 'Unknown',
                            snackPosition: SnackPosition.BOTTOM,
                            duration: Duration(seconds: 2),
                          );
                        }
                      },
                      decoration: const InputDecoration(
                        labelText: 'Subject',
                        border: OutlineInputBorder(),
                      ),
                      value: controller.subjectId.value == 0 ? null : controller.subjectId.value,
                    );
                  }
                }),

                const SizedBox(height: 20,),

                Obx(() {
                  if (controller.teachers.isEmpty) {
                    return Container();
                  } else {
                    return DropdownButtonFormField<int>(
                      items: controller.teachers.map((TeacherModel teacher) {
                        return DropdownMenuItem<int>(
                          value: teacher.teacherId,
                          child: Container(
                            width: 200,
                            child: Text(
                              teacher.name ?? 'Unknown',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          final selectedTeacher = controller.teachers.firstWhere(
                                (teacher) => teacher.teacherId == value,
                            orElse: () => TeacherModel(name: 'Unknown', teacherId: 0),
                          );
                          controller.setTeacherId(value);
                          Get.snackbar(
                            'Selected Teacher',
                            selectedTeacher.name ?? 'Unknown',
                            snackPosition: SnackPosition.BOTTOM,
                            duration: Duration(seconds: 2),
                          );
                        }
                      },
                      decoration: const InputDecoration(
                        labelText: 'Teacher',
                        border: OutlineInputBorder(),
                      ),
                      value: controller.teacherId.value == 0 ? null : controller.teacherId.value,
                    );
                  }
                }),

                const SizedBox(height: 20,),

                Obx(() {
                  return DropdownButtonFormField<String>(
                    items: controller.daysOfWeek.map((day) {
                      return DropdownMenuItem<String>(
                        value: day,
                        child: Text(day),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        controller.day.value = value;
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: 'Day',
                      border: OutlineInputBorder(),
                    ),
                    value: controller.day.value,
                  );
                }),

                const SizedBox(height: 20,),

                FormBuilderDateTimePicker(
                  name: 'startTime',
                  inputType: InputType.time,
                  decoration: const InputDecoration(labelText: 'Start Time'),
                  format: DateFormat('HH:mm:ss'),
                  onChanged: (value) {
                    if (value != null) {
                      final time = TimeOfDay.fromDateTime(value);
                      controller.startTime.value = time;
                    }
                  },
                ),

                const SizedBox(height: 20,),

                FormBuilderDateTimePicker(
                  name: 'endTime',
                  inputType: InputType.time,
                  decoration: const InputDecoration(labelText: 'End Time'),
                  format: DateFormat('HH:mm:ss'),
                  onChanged: (value) {
                    if (value != null) {
                      final time = TimeOfDay.fromDateTime(value);
                      controller.endTime.value = time;
                    }
                  },
                ),

                const SizedBox(height: 20,),

                FormBuilderTextField(
                  name: 'roomName',
                  decoration: const InputDecoration(labelText: 'Room Name'),
                  onChanged: (value) => controller.roomName.value = value ?? '',
                  validator: validateRoomName, // Apply validation
                ),

                const SizedBox(height: 50),

                Obx(() {
                  return ElevatedButton(
                    onPressed: () async {
                      isLoading.value = true;
                      await controller.submit();
                      isLoading.value = false;
                      controller.clearSelections();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                      minimumSize: Size(200, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 5,
                    ),
                    child: isLoading.value
                        ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: Colors.black,
                        strokeWidth: 2,
                      ),
                    )
                        : const Text('Submit', style: TextStyle(fontSize: 16)),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
