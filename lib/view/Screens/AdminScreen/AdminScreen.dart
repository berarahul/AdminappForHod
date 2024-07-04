// import 'package:attendanceadmin/constant/AppColors.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
//
// import 'Widgets/TeacherCard/TeacherScreen.dart';
//
// class AdminScreen extends StatelessWidget {
//   final List<String> buttonNames = [
//     'Student',
//     'Teacher',
//     'Subject'
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blueAccent,
//       appBar: AppBar(
//         backgroundColor: AppColors.appcolor,
//         title: const Center(child: Text('Admin')),
//       ),
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.blueAccent, Colors.lightBlueAccent],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 20),
//               Expanded(
//                 child: GridView.builder(
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     childAspectRatio: 3 / 2,
//                     crossAxisSpacing: 10,
//                     mainAxisSpacing: 10,
//                   ),
//                   itemCount: buttonNames.length,
//                   itemBuilder: (context, index) {
//                     return AdminCard(
//                       title: buttonNames[index],
//                       onTap: () {
//                         if (buttonNames[index] == 'Student') {
//                           Get.toNamed('/student');
//                         } else if (buttonNames[index] == 'Teacher') {
//                           Get.toNamed('/teacher');
//                         }
//                         else if (buttonNames[index] == 'Subject'){
//                           Get.toNamed('/subject');
//                         }
//                         // Define other actions for other buttons here
//                       },
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class AdminCard extends StatelessWidget {
//   final String title;
//   final VoidCallback onTap;
//
//   const AdminCard({required this.title, required this.onTap});
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Card(
//         shadowColor: Colors.black,
//         color: AppColors.appcolor,
//         elevation: 6,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Center(
//           child: Text(
//             title,
//             textAlign: TextAlign.center,
//             style: const TextStyle(
//               fontSize: 30,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:attendanceadmin/constant/AppColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constant/routes/approutes.dart';
import '../../../viewmodel/service/LoginService/AuthServices.dart';
import 'Widgets/TeacherCard/TeacherScreen.dart';

class AdminScreen extends StatelessWidget {
  final List<String> buttonNames = ['Student', 'Teacher', 'Subject'];

  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService authService = Get.put(AuthService());

    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.appcolor,
        title: const Center(child: Text('Admin')),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.lightBlueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: buttonNames.length,
                  itemBuilder: (context, index) {
                    return AdminCard(
                      title: buttonNames[index],
                      onTap: () {
                        if (buttonNames[index] == 'Student') {
                          Get.toNamed(AppRoutes.student);
                        } else if (buttonNames[index] == 'Teacher') {
                          Get.toNamed(AppRoutes.teacher);
                        } else if (buttonNames[index] == 'Subject') {
                          Get.toNamed(AppRoutes.subject);
                        }
                        // Define other actions for other buttons here
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          authService.logout();
          // Implement your logout logic here
          // For example, navigate to login screen and clear session
          Get.offAllNamed('/login'); // Replace with your logout logic
        },
        backgroundColor: AppColors.appcolor,
        tooltip: 'Logout',
        child: const Icon(Icons.logout),
      ),
    );
  }
}

class AdminCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const AdminCard({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shadowColor: Colors.black,
        color: AppColors.appcolor,
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
