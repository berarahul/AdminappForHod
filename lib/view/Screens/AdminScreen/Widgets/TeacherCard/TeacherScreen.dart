import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:attendanceadmin/constant/AppColors.dart';
import '../../../../../sampleUI.dart';
import '../../../../../viewmodel/service/AdminScreenController/WidgetController/TeacherCardServices/TeacherScreenController.dart';
import 'Widgets/AddTeacherWidget.dart';
import 'Widgets/RemoveTeacherWidget.dart';


class TeacherActionScreen extends StatelessWidget {
  TeacherController teacherController=Get.put(TeacherController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appcolor,
        title: const Text('Teacher'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        color: Colors.orange,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Teacher',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  itemCount: teacherController.actions.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: StudentActionWidget(
                        actionText: teacherController.actions[index],
                        onTap: () {
                          _handleAction(context, teacherController.actions[index]);
                        },
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  void _handleAction(BuildContext context, String action) {
    if (action == 'Add Teacher') {
      teacherController.addTeacher();
      _showAddTeacherModal(context);
    } else if (action == 'Remove Teacher') {
      teacherController.removeTeacher();
      _showRemoveTeacherModal(context);
    } else if (action == 'Update Teacher') {
      teacherController.updateTeacher();
      _showUpdateTeacherModal(context);
    }
  }

  void _showAddTeacherModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: AddTeacherModal(),
      ),
    );
  }



  void _showRemoveTeacherModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: RemoveTeacherModel(),
      ),
    );
  }
}


void _showUpdateTeacherModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: TeacherUpdateScreen(),
    ),
  );
}

class StudentActionWidget extends StatelessWidget {
  final String actionText;
  final VoidCallback onTap;

  const StudentActionWidget({
    required this.actionText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          actionText,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
