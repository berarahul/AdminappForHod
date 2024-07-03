// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:attendanceadmin/view/Screens/AdminScreen/AdminScreen.dart';
// import 'package:attendanceadmin/view/Screens/Login/Login_Screen.dart';
// import 'package:attendanceadmin/viewmodel/service/LoginService/AuthServices.dart';
// import 'package:attendanceadmin/viewmodel/service/theme/Apptheme.dart';
//
// class MyApp extends StatelessWidget {
//   MyApp({Key? key}) : super(key: key);
//
//   final AuthService authService = Get.put(AuthService());
//
//   @override
//   Widget build(BuildContext context) {
//     bool isLoggedIn = authService.isLoggedIn(); // This is a local boolean variable
//
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       themeMode: ThemeMode.system,
//       theme: AppTheme.lightTheme,
//       darkTheme: AppTheme.darkTheme,
//       home: isLoggedIn ? AdminScreen() : LoginScreen(),
//       getPages: [
//         GetPage(name: '/admin', page: () => AdminScreen()),
//         // Define other routes as needed
//       ],
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:attendanceadmin/view/Screens/AdminScreen/AdminScreen.dart';
import 'package:attendanceadmin/view/Screens/Login/Login_Screen.dart';
import 'package:attendanceadmin/viewmodel/service/LoginService/AuthServices.dart';
import 'package:attendanceadmin/viewmodel/service/theme/Apptheme.dart';

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // Remove the final keyword from authService declaration
  final AuthService authService = Get.put(AuthService());

  @override
  Widget build(BuildContext context) {
    // Move isLoggedIn inside the build method to fetch the latest value
    bool isLoggedIn = authService.isLoggedIn(); // This should be called inside build method

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      // Correctly use isLoggedIn to determine initial screen
      home: isLoggedIn ? AdminScreen() : LoginScreen(),
      getPages: [
        GetPage(name: '/admin', page: () => AdminScreen()),
        // Define other routes as needed
      ],
    );
  }
}
