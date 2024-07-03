import 'package:attendanceadmin/view/Screens/AdminScreen/AdminScreen.dart';
import 'package:attendanceadmin/view/Screens/AdminScreen/Widgets/StudentCard/StudentScreen.dart';

import 'package:attendanceadmin/view/Screens/AdminScreen/Widgets/SubjectCard/SubjectScreen.dart';
import 'package:attendanceadmin/view/Screens/AdminScreen/Widgets/TeacherCard/TeacherScreen.dart';
import 'package:attendanceadmin/view/Screens/Login/Login_Screen.dart';
import 'package:attendanceadmin/viewmodel/service/LoginService/AuthServices.dart';
import 'package:attendanceadmin/viewmodel/service/theme/Apptheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final AuthService authService = Get.put(AuthService());
  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = authService.isLoggedIn();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: isLoggedIn ? AdminScreen() : LoginScreen(),
      // home: AdminScreen(),
      // getPages: [
      //   GetPage(name: '/student', page: () => StudentActionsScreen()),
      //   GetPage(name: '/teacher', page: () => TeacherActionsScreen()),
      //   GetPage(name: '/login', page: () => LoginScreen()),
      //   GetPage(name: '/subject', page: () => SubjectActionsScreen()), // Add the new screen route

        // Add other pages here
      // ],
    );
  }
}
