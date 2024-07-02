import 'package:get/get.dart';

class UpdateStudentController extends GetxController {
  var selectedSemester = ''.obs;
  var semesters = ['Semester 1', 'Semester 2', 'Semester 3'].obs;
  var students = {
    'Semester 1': ['John Doe', 'Jane Smith'],
    'Semester 2': ['Alice Johnson', 'Bob Brown'],
    'Semester 3': ['Charlie Davis', 'David Evans']
  }.obs;
  var filteredStudents = <String>[].obs; // Use a simple list instead of Map
  var searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Initially load students for the first semester
    fetchStudents(semesters.first);
  }

  void fetchStudents(String semester) {
    selectedSemester.value = semester;
    filteredStudents.assignAll(students[semester]!);
  }

  void updateStudentName(int index, String newName) {
    filteredStudents[index] = newName;
    students[selectedSemester.value]![index] = newName;
  }

  void searchStudents(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      filteredStudents.assignAll(students[selectedSemester.value]!);
    } else {
      filteredStudents.assignAll(students[selectedSemester.value]!
          .where((student) => student.toLowerCase().contains(query.toLowerCase()))
          .toList());
    }
  }
}
