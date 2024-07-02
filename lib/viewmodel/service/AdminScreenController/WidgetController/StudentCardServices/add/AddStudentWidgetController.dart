import 'package:get/get.dart';

class AddStudentController extends GetxController {
  var studentName = ''.obs;

  void setStudentName(String name) {
    studentName.value = name;
  }

  void submit() {
    // Implement your submit logic here, e.g., API call or data handling
    print('Submitting student: ${studentName.value}');
    // Add your logic to submit the student data, e.g., call an API
    // Reset the input after submission
    studentName.value = '';
  }
}
