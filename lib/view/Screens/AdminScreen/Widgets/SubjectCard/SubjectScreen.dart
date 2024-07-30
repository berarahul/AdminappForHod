import 'package:attendanceadmin/view/Screens/AdminScreen/Widgets/SubjectCard/Widgets/AddNewSubjectWidget.dart';
import 'package:attendanceadmin/view/Screens/AdminScreen/Widgets/SubjectCard/Widgets/RemoveSubjectWidget.dart';
import 'package:attendanceadmin/view/Screens/AdminScreen/Widgets/SubjectCard/Widgets/UpdateSubjectWidget.dart';
import 'package:attendanceadmin/viewmodel/service/AdminScreenController/WidgetController/SubjectsCardService/SubjectScreenControl.dart';
import 'package:attendanceadmin/viewmodel/service/AdminScreenController/WidgetController/TeacherCardServices/TeacherScreenController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:attendanceadmin/constant/AppColors.dart';
import '../../../../../viewmodel/service/AdminScreenController/WidgetController/StudentCardServices/StudentScreenController.dart';



class SubjectActionScreen extends StatelessWidget {
  final SubjectController controller = Get.put(SubjectController());

  SubjectActionScreen({super.key});

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
            const Padding(
              padding: EdgeInsets.only(top: 40.0, bottom: 20.0),
              child: Text(
                'Subject',
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
                        child: SubjectActionWidget(
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
      // Morning gradient
      gradientColors = [Colors.yellow, Colors.lightBlueAccent];
    } else if (hour >= 12 && hour < 17) {
      // Afternoon gradient
      gradientColors = [Colors.blue, Colors.lightBlue];
    }else if (hour >= 17 && hour < 22) {
      gradientColors=[AppColors.softRed,AppColors.peach];
    }

    else {
      // Evening gradient
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
    if (action == 'Add new subject') {
      controller.addSubject();
      _showAddStudentModal(context);
    } else if (action == 'Remove subject') {
      controller.removeSubject();
      _showRemoveStudentModal(context);
    } else if (action == 'Update subject') {
      controller.updateSubject();
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
      child: AddSubjectModal(),
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
      child: RemoveSubjectModal(),
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
      child: UpdateSubjectModal(),
    ),
  );
}





class SubjectActionWidget extends StatelessWidget {
  final String actionText;
  final int index;

  const SubjectActionWidget({
    Key? key,
    required this.actionText,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hour = DateTime.now().hour;
    List<Color> cardColors = [];

    // if (hour < 12) {
    //   // Morning gradient
    //   cardColors = [Colors.yellow, Colors.lightBlueAccent];
    // } else if (hour < 18) {
    //   // Afternoon gradient
    //   cardColors = [Colors.blue, Colors.lightBlue];
    // } else {
    //   // Evening gradient
    //   cardColors = [Colors.deepPurple, Colors.purple];
    // }



    if (hour >= 6 && hour < 12) {
      // Morning gradient
      cardColors = [Colors.yellow, Colors.lightBlueAccent];
    } else if (hour >= 12 && hour < 17) {
      // Afternoon gradient
      cardColors = [Colors.orangeAccent, Colors.yellowAccent];
    }else if (hour >= 17 && hour < 22) {
      cardColors=[AppColors.softRed,AppColors.peach];
    }

    else {
      // Evening gradient
      cardColors = [Colors.indigo, Colors.black];
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
      case 'Add new subject':
        iconData = Icons.add_circle_outline;
        break;
      case 'Remove subject':
        iconData = Icons.remove_circle_outline;
        break;
      case 'Update subject':
        iconData = Icons.update;
        break;
      default:
        iconData = Icons.error_outline;
    }
    return Icon(iconData);
  }
}
