



import 'package:get/get.dart';

class StudentController extends GetxController {
  var selectedSemester = ''.obs;
  var students = <String>[].obs;
  var filteredStudents = <String>[].obs;
  var selectedStudents = <String>[].obs;
  var actions = ['Add Student', 'Remove Student', 'Update Student', 'Remove student from last sem'].obs;
  var semesters = ['Semester 1', 'Semester 2', 'Semester 3'].obs;

  void filterSearchResults(String query) {
    if (query.isNotEmpty) {
      filteredStudents.value = students.where((student) => student.toLowerCase().contains(query.toLowerCase())).toList();
    } else {
      filteredStudents.value = students;
    }
  }

  void fetchStudents(String semester) {
    // Mock data fetching based on selected semester
    students.value = ['Student 1', 'Student 2', 'Student 3']; // Replace with actual data fetching logic
    filteredStudents.value = students;
  }

  void addOrRemoveStudent(String student, bool isSelected) {
    if (isSelected) {
      selectedStudents.add(student);
    } else {
      selectedStudents.remove(student);
    }
  }

  void selectAllStudents(bool isSelected) {
    if (isSelected) {
      selectedStudents.value = List.from(filteredStudents);
    } else {
      selectedStudents.clear();
    }
  }

  void removeSelectedStudents() {
    students.removeWhere((student) => selectedStudents.contains(student));
    filteredStudents.removeWhere((student) => selectedStudents.contains(student));
    selectedStudents.clear();
  }

  void updateStudentName(int index, String newName) {
    students[index] = newName;
    filteredStudents[index] = newName;
    update(); // Notify listeners to update UI
  }
}
