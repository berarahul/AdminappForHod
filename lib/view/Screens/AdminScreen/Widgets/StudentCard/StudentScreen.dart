import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:attendanceadmin/constant/AppColors.dart';
import '../../../../../viewmodel/service/AdminScreenController/WidgetController/StudentCardServices/StudentScreenController.dart';
import 'Widgets/AddStudentWidget.dart';
import 'Widgets/RemoveStudentFromLastSemWidget.dart';
import 'Widgets/RemoveStudentWidget.dart';
import 'Widgets/SemesterEdit.dart';
import 'Widgets/UpdateStudentWidget.dart';

class StudentActionsScreen extends StatelessWidget {
  final StudentController controller = Get.put(StudentController());

  StudentActionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appcolor,
        title: const Text('Student'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        color: Colors.orange,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Student',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  itemCount: controller.actions.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: StudentActionWidget(
                        actionText: controller.actions[index],
                        onTap: () {
                          _handleAction(context, controller.actions[index]);
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
    if (action == 'Add Student') {
      controller.addStudent();
      _showAddStudentModal(context);
    } else if (action == 'Remove Student') {
      controller.removeStudent();
      _showRemoveStudentModal(context);
    } else if (action == 'Update Student') {
      controller.updateStudent();
      _showUpdateStudentModal(context);
    } else if (action == 'Remove student from last sem') {
      controller.removeStudentFromLastSem();
      _showRemoveStudentFromLastSemModal(context);
    }
    else if (action=='Student Transfer Using Semester id') {
      controller.semesterAdd();
      __showAddSemesterModal(context);
    }
  }

  void _showAddStudentModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: AddStudentModal(),
      ),
    );
  }

  void _showRemoveStudentModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: RemoveStudentModal(),
      ),
    );
  }

  void _showUpdateStudentModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: UpdateStudentModal(),
      ),
    );
  }

  void _showRemoveStudentFromLastSemModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Removestudentfromlastsemwidget(),
      ),
    );
  }

  void __showAddSemesterModal(BuildContext context) {
    showModalBottomSheet(

        context: context,
    isScrollControlled: true,
      builder: (context) =>
          Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery
                  .of(context)
                  .viewInsets
                  .bottom,
            ),
            child: AddSemesterScreen(),
          ),
    );
  }

}





class StudentActionWidget extends StatelessWidget {
  final String actionText;
  final VoidCallback onTap;

  const StudentActionWidget({
    super.key,
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
