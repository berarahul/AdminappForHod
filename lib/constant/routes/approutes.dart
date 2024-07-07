// lib/routes/app_routes.dart
import 'package:get/get.dart';
import 'package:attendanceadmin/view/Screens/AdminScreen/AdminScreen.dart';
import 'package:attendanceadmin/view/Screens/Login/Login_Screen.dart';

import '../../view/Screens/AdminScreen/Widgets/StudentCard/StudentScreen.dart';
import '../../view/Screens/AdminScreen/Widgets/SubjectCard/SubjectScreen.dart';
import '../../view/Screens/AdminScreen/Widgets/TeacherCard/TeacherScreen.dart';
// import other screens as needed

class AppRoutes {
  static const String login = '/login';
  static const String admin = '/admin';
  static const String student = '/student';
  static const String teacher = '/teacher';
  static const String subject = '/subject';

  static List<GetPage> routes = [
    GetPage(name: login, page: () => LoginScreen()),
    GetPage(name: admin, page: () => AdminScreen()),
    GetPage(name: student, page: () => StudentActionsScreen()), // Ensure these screens are implemented
    GetPage(name: teacher, page: () => TeacherActionsScreen()),
    GetPage(name: subject, page: () => SubjectActionScreen()),
  ];
}
