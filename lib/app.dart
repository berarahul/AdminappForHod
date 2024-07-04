import 'package:attendanceadmin/constant/routes/approutes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:attendanceadmin/view/Screens/AdminScreen/AdminScreen.dart';
import 'package:attendanceadmin/view/Screens/Login/Login_Screen.dart';
import 'package:attendanceadmin/viewmodel/service/LoginService/AuthServices.dart';
import 'package:attendanceadmin/viewmodel/service/theme/Apptheme.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final AuthService authService = Get.put(AuthService());

  @override
  Widget build(BuildContext context) {
    bool isLoggedIn =
        authService.isLoggedIn(); // This is a local boolean variable

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      // initialRoute: AppRoutes.login,
      home: isLoggedIn ? AdminScreen() : LoginScreen(),
      getPages: AppRoutes.routes,
    );
  }
}
