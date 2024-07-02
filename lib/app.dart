import 'package:attendanceadmin/view/Screens/AdminScreen/AdminScreen.dart';
import 'package:attendanceadmin/view/Screens/AdminScreen/Widgets/StudentCard/StudentScreen.dart';

import 'package:attendanceadmin/view/Screens/AdminScreen/Widgets/SubjectCard/SubjectScreen.dart';
import 'package:attendanceadmin/view/Screens/AdminScreen/Widgets/TeacherCard/TeacherScreen.dart';
import 'package:attendanceadmin/view/Screens/Login/Login_Screen.dart';
import 'package:attendanceadmin/viewmodel/service/theme/Apptheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: AdminScreen(),
      getPages: [
        GetPage(name: '/student', page: () => StudentActionsScreen()),
        GetPage(name: '/teacher', page: () => TeacherActionsScreen()),
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(
          name: '/subject',
          page: () => const SubjectActionsScreen(),
        ), // Add the new screen route

        // Add other pages here
      ],
    );
  }
}
