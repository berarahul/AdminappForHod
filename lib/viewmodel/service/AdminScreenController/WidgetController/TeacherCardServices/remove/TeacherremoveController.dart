import 'package:get/get.dart';

import '../../../../../../model/TeacheModel.dart';



class RemoveTeacherController extends GetxController {
  var teachers = <Teacher>[
    Teacher(id: 1, name: 'Partha', semesterId: 1),
    Teacher(id: 2, name: 'Skg', semesterId: 1),
    Teacher(id: 3, name: 'aditi', semesterId: 2),
    Teacher(id: 4, name: 'Habib', semesterId: 2),
    Teacher(id: 5, name: 'saytajit', semesterId: 3),
    Teacher(id: 6, name: 'pradip', semesterId: 3),
  ].obs;

  var selectedSemester = RxInt(0);

  List<Teacher> get filteredTeachers {
    return teachers.where((teachers) => teachers.semesterId == selectedSemester.value).toList();
  }

  void removeTeachers(int id) {
    teachers.removeWhere((teachers) => teachers.id == id);
  }
}
