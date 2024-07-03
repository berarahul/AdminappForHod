import 'package:get/get.dart';

class Updatesubjectcontroller extends GetxController {
  var selectedSemester = ''.obs;
  var semesters = ['Semester 1', 'Semester 2', 'Semester 3'].obs;
  var subjects = {
    'Semester 1': ['Math', 'Computer Science'],
    'Semester 2': ['Bengali', 'English'],
    'Semester 3': ['Automata', 'Computer Network']
  }.obs;
  var filteredSubjects = <String>[].obs; // Use a simple list instead of Map
  var searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Initially load students for the first semester
    fetchSubjects(semesters.first);
  }

  void fetchSubjects(String semester) {
    selectedSemester.value = semester;
    filteredSubjects.assignAll(subjects[semester]!);
  }

  void updateStudentName(int index, String newName) {
    filteredSubjects[index] = newName;
    subjects[selectedSemester.value]![index] = newName;
  }

  void searchStudents(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      filteredSubjects.assignAll(subjects[selectedSemester.value]!);
    } else {
      filteredSubjects.assignAll(subjects[selectedSemester.value]!
          .where((student) => student.toLowerCase().contains(query.toLowerCase()))
          .toList());
    }
  }
}
