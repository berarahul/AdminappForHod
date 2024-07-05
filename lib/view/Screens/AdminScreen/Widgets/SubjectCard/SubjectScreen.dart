import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:attendanceadmin/constant/AppColors.dart';
import '../../../../../viewmodel/service/AdminScreenController/WidgetController/StudentCardServices/StudentScreenController.dart';
import '../../../../../viewmodel/service/AdminScreenController/WidgetController/SubjectsCardService/SubjectScreenControl.dart';
import '../StudentCard/Widgets/UpdateStudentWidget.dart';
import 'Widgets/AddNewSubjectWidget.dart';
import 'Widgets/RemoveSubjectWidget.dart';
import 'Widgets/UpdateSubjectWidget.dart';

class SubjectActionScreen extends StatelessWidget {
  final SubjectController controller = Get.put(SubjectController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appcolor,
        title: const Text('Subject'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        color: Colors.orange,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Subject',
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
    if (action == 'Add new subject') {
      controller.addSubject();
      _showAddSubjetModal(context);
    } else if (action == 'Update subject') {
      controller.updateSubject();
      _showUpdateSubjectModal(context);
    } else if (action == 'Remove subject') {
      controller.removeSubject();
      _showRemoveSubjectModal(context);
    }
  }

  void _showAddSubjetModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: AddSubjectModal(),
      ),
    );
  }

  void _showUpdateSubjectModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: UpdateSubjectModal(),
      ),
    );
  }

  void _showRemoveSubjectModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: RemoveSubjectScreen(),
      ),
    );
  }
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
