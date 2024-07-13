import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                'Students',
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
    } else if (action == 'Student Transfer') {
      controller.semesterAdd();
      _showAddSemesterModal(context);
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

  void _showAddSemesterModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: AddSemesterScreen(),
      ),
    );
  }
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
      case 'Add Student':
        iconData = Icons.add_circle_outline;
        break;
      case 'Remove Student':
        iconData = Icons.remove_circle_outline;
        break;
      case 'Update Student':
        iconData = Icons.update;
        break;
      case 'Remove student from last sem':
        iconData = Icons.delete_outline;
        break;
      case 'Student Transfer':
        iconData = Icons.school;
        break;
      default:
        iconData = Icons.error_outline;
    }
    return Icon(iconData);
  }
}
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'dart:async';
//
// import '../../../../../viewmodel/service/AdminScreenController/WidgetController/StudentCardServices/StudentScreenController.dart';
// import 'Widgets/AddStudentWidget.dart';
// import 'Widgets/RemoveStudentFromLastSemWidget.dart';
// import 'Widgets/RemoveStudentWidget.dart';
// import 'Widgets/SemesterEdit.dart';
// import 'Widgets/UpdateStudentWidget.dart';
//
// class StudentActionsScreen extends StatefulWidget {
//   @override
//   _StudentActionsScreenState createState() => _StudentActionsScreenState();
// }
//
// class _StudentActionsScreenState extends State<StudentActionsScreen> {
//   final StudentController controller = Get.put(StudentController());
//   List<List<Color>> _colorSets = [
//     [Colors.yellow, Colors.lightBlueAccent],
//     [Colors.blue, Colors.lightBlue],
//     [Colors.deepPurple, Colors.purple],
//   ];
//   int _index = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     _startColorAnimation();
//   }
//
//   void _startColorAnimation() {
//     Timer.periodic(Duration(seconds: 2), (timer) {
//       setState(() {
//         _index = (_index + 1) % _colorSets.length;
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         shadowColor: Colors.transparent,
//         automaticallyImplyLeading: true,
//         systemOverlayStyle: SystemUiOverlayStyle.light,
//       ),
//       body: TweenAnimationBuilder(
//         tween: ColorTween(begin: _colorSets[_index][0], end: _colorSets[_index][1]),
//         duration: Duration(seconds: 5),
//         builder: (context, Color? color, child) {
//           return Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [color!, color.withOpacity(0.7)], // You can modify the opacity as needed
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(top: 40.0, bottom: 20.0),
//                   child: Text(
//                     'Students',
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: Obx(() {
//                     return ListView.builder(
//                       itemCount: controller.actions.length,
//                       itemBuilder: (context, index) {
//                         return Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 8.0),
//                           child: GestureDetector(
//                             onTap: () {
//                               _handleAction(context, controller.actions[index]);
//                             },
//                             child: StudentActionWidget(
//                               actionText: controller.actions[index],
//                               index: index,
//                             ),
//                           ),
//                         );
//                       },
//                     );
//                   }),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   void _handleAction(BuildContext context, String action) {
//     if (action == 'Add Student') {
//       controller.addStudent();
//       _showAddStudentModal(context);
//     } else if (action == 'Remove Student') {
//       controller.removeStudent();
//       _showRemoveStudentModal(context);
//     } else if (action == 'Update Student') {
//       controller.updateStudent();
//       _showUpdateStudentModal(context);
//     } else if (action == 'Remove student from last sem') {
//       controller.removeStudentFromLastSem();
//       _showRemoveStudentFromLastSemModal(context);
//     } else if (action == 'Student Transfer Using Semester id') {
//       controller.semesterAdd();
//       _showAddSemesterModal(context);
//     }
//   }
//
//   void _showAddStudentModal(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       builder: (context) => Padding(
//         padding: EdgeInsets.only(
//           bottom: MediaQuery.of(context).viewInsets.bottom,
//         ),
//         child: AddStudentModal(),
//       ),
//     );
//   }
//
//   void _showRemoveStudentModal(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       builder: (context) => Padding(
//         padding: EdgeInsets.only(
//           bottom: MediaQuery.of(context).viewInsets.bottom,
//         ),
//         child: RemoveStudentModal(),
//       ),
//     );
//   }
//
//   void _showUpdateStudentModal(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       builder: (context) => Padding(
//         padding: EdgeInsets.only(
//           bottom: MediaQuery.of(context).viewInsets.bottom,
//         ),
//         child: UpdateStudentModal(),
//       ),
//     );
//   }
//
//   void _showRemoveStudentFromLastSemModal(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       builder: (context) => Padding(
//         padding: EdgeInsets.only(
//           bottom: MediaQuery.of(context).viewInsets.bottom,
//         ),
//         child: Removestudentfromlastsemwidget(),
//       ),
//     );
//   }
//
//   void _showAddSemesterModal(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       builder: (context) => Padding(
//         padding: EdgeInsets.only(
//           bottom: MediaQuery.of(context).viewInsets.bottom,
//         ),
//         child: AddSemesterScreen(),
//       ),
//     );
//   }
// }
//
// class StudentActionWidget extends StatelessWidget {
//   final String actionText;
//   final int index;
//
//   const StudentActionWidget({
//     Key? key,
//     required this.actionText,
//     required this.index,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final hour = DateTime.now().hour;
//     List<Color> cardColors = [];
//
//     if (hour < 12) {
//       // Morning gradient
//       cardColors = [Colors.yellow, Colors.lightBlueAccent];
//     } else if (hour < 18) {
//       // Afternoon gradient
//       cardColors = [Colors.blue, Colors.lightBlue];
//     } else {
//       // Evening gradient
//       cardColors = [Colors.deepPurple, Colors.purple];
//     }
//
//     return Card(
//       color: Colors.white.withOpacity(0.3), // Semi-transparent white
//       child: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: cardColors,
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 actionText,
//                 style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.normal,
//                 ),
//               ),
//               _buildIconForAction(actionText),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildIconForAction(String actionText) {
//     IconData iconData;
//     switch (actionText) {
//       case 'Add Student':
//         iconData = Icons.add_circle_outline;
//         break;
//       case 'Remove Student':
//         iconData = Icons.remove_circle_outline;
//         break;
//       case 'Update Student':
//         iconData = Icons.update;
//         break;
//       case 'Remove student from last sem':
//         iconData = Icons.delete_outline;
//         break;
//       case 'Student Transfer Using Semester id':
//         iconData = Icons.school;
//         break;
//       default:
//         iconData = Icons.error_outline;
//     }
//     return Icon(iconData);
//   }
// }
