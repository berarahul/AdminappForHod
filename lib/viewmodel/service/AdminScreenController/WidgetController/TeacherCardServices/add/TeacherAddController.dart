import 'package:get/get.dart';

class Teacheraddcontroller extends GetxController {
  var teacherName = ''.obs; // Observable variable to hold the subject name
  var selectedSemester = RxInt(1); // Observable variable to hold the selected semester

  void setTeacherName(String name) {
    teacherName.value = name; // Method to set the subject name
  }

  void setSemester(int semester) {
    selectedSemester.value = semester; // Method to set the selected semester
  }

  void submit() {
    // Submit method to handle the submission of the subject
    print('Submitting subject: ${teacherName.value} for Semester ${selectedSemester.value}');
    // Here you would typically implement your logic to submit the subject,
    // such as making an API call or saving data to a database.

    // Reset the subject name after submission (optional, depending on your needs)
    teacherName.value = '';
  }
}
