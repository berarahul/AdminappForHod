class StudentCardApi {
  StudentCardApi._();
  // Add student endpoint
  static const String addStudentEndPoint = "hod/student/addStudent";

  // Update student endpoint
  // we will need to pass the departmentId and semesterId
  // then we will get roll and student names
  // final endpoint will be like this "hod/student/$departmentId/$semesterId"
  static const String studentListEndPoint = "student";

  // Department list endpoint
  // need to pass the departmentId
  // then we will get the list of departmentsID and other
  // final endpoint will be like this "hod/dept/$departmentId"
  static const String departmentListEndPoint = "dept";
}
