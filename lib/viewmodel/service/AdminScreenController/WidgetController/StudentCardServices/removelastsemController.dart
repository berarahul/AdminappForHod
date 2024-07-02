import 'package:get/get.dart';

class RemoveStudentControllerFromLastSem extends GetxController {
  var students = [
    'John Doe',
    'Jane Smith',
    'Alice Johnson',
    'Bob Brown',
    'Charlie Davis',
    'David Evans'
  ].obs;

  var filteredStudents = [].obs;
  var selectedStudents = <String>[].obs;
  var searchQuery = ''.obs;

  @override
  void onInit() {
    filteredStudents.assignAll(students);
    super.onInit();
  }

  void filterStudents() {
    if (searchQuery.isEmpty) {
      filteredStudents.assignAll(students);
    } else {
      filteredStudents.assignAll(students.where((student) =>
          student.toLowerCase().contains(searchQuery.value.toLowerCase())).toList());
    }
  }

  void filterSearchResults(String query) {
    searchQuery.value = query;
    filterStudents();
  }

  void selectAllStudents(bool select) {
    if (select) {
      selectedStudents.assignAll(filteredStudents.map((student) => student));
    } else {
      selectedStudents.clear();
    }
    update(); // Ensure UI update after selecting all or clearing selection
  }

  void addOrRemoveStudent(String student, bool selected) {
    if (selected) {
      selectedStudents.add(student);
    } else {
      selectedStudents.remove(student);
    }
    update(); // Ensure UI update after adding/removing student
  }

  void removeSelectedStudents() {
    students.removeWhere((student) => selectedStudents.contains(student));
    selectedStudents.clear();
    filterStudents(); // Update filtered list after removal
  }
}
