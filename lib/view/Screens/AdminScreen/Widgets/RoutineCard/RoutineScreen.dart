import 'package:attendanceadmin/viewmodel/service/AdminScreenController/WidgetController/RoutineCardServices/RoutineScreenController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:attendanceadmin/constant/AppColors.dart';
import 'Widgets/AddClassWidget.dart';
import 'Widgets/Dropdown/DropDownForRoutine.dart'; // Rename these imports as needed


class RoutineScreen extends StatelessWidget {
  final Routinescreencontroller controller = Get.put(Routinescreencontroller());

  RoutineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Add this line
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: _buildBackgroundDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 40.0, bottom: 20.0),
              child: Text(
                'Routine Management',
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
                        child: RoutineActionWidget(
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

    if (hour >= 6 && hour < 12) {
      gradientColors = [Colors.yellow, Colors.lightBlueAccent];
    } else if (hour >= 12 && hour < 17) {
      gradientColors = [Colors.blue, Colors.lightBlue];
    } else if (hour >= 17 && hour < 22) {
      gradientColors = [AppColors.softRed, AppColors.peach];
    } else {
      gradientColors = [Colors.indigo, Colors.black];
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
    if (action == 'Add Class') {
      controller.addClass();
      _showAddClassModal(context);
    } else if (action == 'View and Update Routine') {
      controller.updateRoutine();
      _showUpdateRoutineModal(context);
    }
  }

  void _showAddClassModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: AddClassScreen(),
      ),
    );
  }

  void _showUpdateRoutineModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
       child: DropdownScreenForRoutine(),
      ),
    );
  }






}

class RoutineActionWidget extends StatelessWidget {
  final String actionText;
  final int index;

  const RoutineActionWidget({
    Key? key,
    required this.actionText,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hour = DateTime.now().hour;
    List<Color> cardColors = [];
    if (hour >= 6 && hour < 12) {
      cardColors = [Colors.yellow, Colors.lightBlueAccent];
    } else if (hour >= 12 && hour < 17) {
      cardColors = [Colors.orangeAccent, Colors.yellowAccent];
    } else if (hour >= 17 && hour < 22) {
      cardColors = [AppColors.softRed, AppColors.peach];
    } else {
      cardColors = [Colors.indigo, Colors.black];
    }

    return Card(
      color: Colors.white.withOpacity(0.3),
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
      case 'Add Class':
        iconData = Icons.add_circle_outline;
        break;
      case 'View and Update Routine':
        iconData = Icons.update;
        break;
      default:
        iconData = Icons.error_outline;
    }
    return Icon(iconData);
  }
}
