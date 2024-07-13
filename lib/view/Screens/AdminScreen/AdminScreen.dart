import 'package:attendanceadmin/constant/AppColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constant/routes/approutes.dart';
import '../../../viewmodel/service/LoginService/AuthServices.dart';

class AdminScreen extends StatelessWidget {
  final List<String> buttonNames = ['Student', 'Teacher', 'Subject'];
  final List<String> iconPaths = [
    'assets/images/student_icon.png', // replace with your student icon path
    'assets/images/teacher_icon.jpg', // replace with your teacher icon path
    'assets/images/subject_icon.png'  // replace with your subject icon path
  ];

  AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService authService = Get.put(AuthService());
    final DateTime now = DateTime.now();
    final String greeting;
    final List<Color> gradientColors;

    if (now.hour >= 6 && now.hour < 12) {
      greeting = 'Good Morning';
      gradientColors = [Colors.yellow, Colors.lightBlueAccent];
    } else if (now.hour >= 12 && now.hour < 17) {
      greeting = 'Good Afternoon';
      gradientColors = [Colors.orangeAccent, Colors.yellowAccent];
    } else if (now.hour >= 17 && now.hour < 22){
      greeting = 'Good Evening';
      gradientColors = [AppColors.softRed, AppColors.peach];
    }

    else {
      greeting = 'Good Night';
      gradientColors = [Colors.indigo, Colors.black];
    }

    return Scaffold(
      // backgroundColor: Colors.blueAccent,
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   // backgroundColor: AppColors.appcolor,
      //
      //   title: const Center(child: Text('Admin')),
      // ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
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
              Text(
                greeting,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Column(
                children: List.generate(buttonNames.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: AdminCard(
                            title: buttonNames[index],
                            iconPath: iconPaths[index],
                            onTap: () {
                              if (buttonNames[index] == 'Student') {
                                Get.toNamed(AppRoutes.student);
                              } else if (buttonNames[index] == 'Teacher') {
                                Get.toNamed(AppRoutes.teacher);
                              } else if (buttonNames[index] == 'Subject') {
                                Get.toNamed(AppRoutes.subject);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Logout'),
              content: const Text('Are you sure you want to log out?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Get.back(); // Close the dialog
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    authService.logout();
                    Get.offAllNamed('/login');
                  },
                  child: const Text('Logout'),
                ),
              ],
            ),
          );
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
  final String iconPath;
  final VoidCallback onTap;

  const AdminCard({super.key, required this.title, required this.iconPath, required this.onTap});

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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              IconCard(iconPath: iconPath),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class IconCard extends StatelessWidget {
  final String iconPath;

  const IconCard({super.key, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Image.asset(
        iconPath,
        width: 50,
        height: 50,
      ),
    );
  }
}
