import 'package:get/get.dart';

class RemoveStudentController extends GetxController {
  // Example data structure for semesters and students
  RxList<String> semesters = ['Semester 1', 'Semester 2', 'Semester 3'].obs;
  RxString selectedSemester = ''.obs;
  RxList students = [].obs;
  RxList filteredStudents = [].obs;
  RxList selectedStudents = [].obs;

  // Simulated API call to fetch students based on selected semester
  void fetchStudents(String semester) {
    // Example: Replace with your actual API call to fetch students
    // This is a simulated asynchronous call
    Future.delayed(Duration(seconds: 1), () {
      students.clear();
      // Simulated data based on semester selection
      if (semester == 'Semester 1') {
        students.addAll(['Alice', 'Bob', 'Charlie']);
      } else if (semester == 'Semester 2') {
        students.addAll(['David', 'Emily', 'Frank']);
      } else if (semester == 'Semester 3') {
        students.addAll(['Grace', 'Henry', 'Ivy']);
      }
      // Update filtered students initially with all students
      filteredStudents.assignAll(students);
    });
  }

  // Filter student list based on search query
  void filterSearchResults(String query) {
    if (query.isEmpty) {
      filteredStudents.assignAll(students);
    } else {
      final lowercaseQuery = query.toLowerCase();
      filteredStudents.assignAll(students.where((student) =>
          student.toLowerCase().contains(lowercaseQuery)));
    }
  }

  // Select or deselect all students
  void selectAllStudents(bool selectAll) {
    if (selectAll) {
      selectedStudents.assignAll(filteredStudents);
    } else {
      selectedStudents.clear();
    }
  }

  // Add or remove a student from the selected list
  void addOrRemoveStudent(String student, bool selected) {
    if (selected) {
      if (!selectedStudents.contains(student)) {
        selectedStudents.add(student);
      }
    } else {
      selectedStudents.remove(student);
    }
  }

  // Remove selected students (example logic)
  void removeSelectedStudents() {
    // Example logic to remove selected students
    print('Removing students: $selectedStudents');
    // Implement your logic here to remove students, e.g., API call
    // Clear selected students after removal
    selectedStudents.clear();
  }
}
