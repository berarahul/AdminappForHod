import 'package:attendanceadmin/viewmodel/service/AdminScreenController/WidgetController/TeacherCardServices/TeacherScreenController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:attendanceadmin/constant/AppColors.dart';
import '../../../../../viewmodel/service/AdminScreenController/WidgetController/StudentCardServices/StudentScreenController.dart';
import 'Widgets/AddTeacherWidget.dart';
import 'Widgets/RemoveTeacherWidget.dart';
import 'Widgets/UpdateTeacherWidget.dart';


class TeacherActionsScreen extends StatelessWidget {
  final TeacherController controller = Get.put(TeacherController());

  TeacherActionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Add this line
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   shadowColor: Colors.transparent,
      //   automaticallyImplyLeading: true,
      //   systemOverlayStyle: SystemUiOverlayStyle.light, // Add this line for light status bar icons
      // ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: _buildBackgroundDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40.0, bottom: 20.0),
              child: Text(
                'Teacher',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  itemCount: controller.actions.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          _handleAction(context, controller.actions[index]);
                        },
                        child: StudentActionWidget(
                          actionText: controller.actions[index],
                          index: index,
                        ),
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

  BoxDecoration _buildBackgroundDecoration() {
    final hour = DateTime.now().hour;
    List<Color> gradientColors = [];

    if (hour < 12) {
      // Morning gradient
      gradientColors = [Colors.yellow, Colors.lightBlueAccent];
    } else if (hour < 18) {
      // Afternoon gradient
      gradientColors = [Colors.blue, Colors.lightBlue];
    } else {
      // Evening gradient
      gradientColors = [Colors.deepPurple, Colors.purple];
    }

    return BoxDecoration(
      gradient: LinearGradient(
        colors: gradientColors,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    );
  }

  void _handleAction(BuildContext context, String action) {
    if (action == 'Add Teacher') {
      controller.addTeacher();
      _showAddStudentModal(context);
    } else if (action == 'Remove Teacher') {
      controller.removeTeacher();
      _showRemoveStudentModal(context);
    } else if (action == 'Update Teacher') {
      controller.updateTeacher();
      _showUpdateStudentModal(context);
    }
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
        child: AddTeacherModal(),
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
        child: RemoveTeacherModel(),
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
        child: UpdateTeacherModal(),
      ),
    );
  }





class StudentActionWidget extends StatelessWidget {
  final String actionText;
  final int index;

  const StudentActionWidget({
    Key? key,
    required this.actionText,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hour = DateTime.now().hour;
    List<Color> cardColors = [];

    if (hour < 12) {
      // Morning gradient
      cardColors = [Colors.yellow, Colors.lightBlueAccent];
    } else if (hour < 18) {
      // Afternoon gradient
      cardColors = [Colors.blue, Colors.lightBlue];
    } else {
      // Evening gradient
      cardColors = [Colors.deepPurple, Colors.purple];
    }

    return Card(
      color: Colors.white.withOpacity(0.3), // Semi-transparent white
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: cardColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                actionText,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
              _buildIconForAction(actionText),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconForAction(String actionText) {
    IconData iconData;
    switch (actionText) {
      case 'Add Teacher':
        iconData = Icons.add_circle_outline;
        break;
      case 'Remove Teacher':
        iconData = Icons.remove_circle_outline;
        break;
      case 'Update Teacher':
        iconData = Icons.update;
        break;
      default:
        iconData = Icons.error_outline;
    }
    return Icon(iconData);
  }
}
