class CreateTeacherModel {
  String name;
  String userName;
  String password;
  String confirmPassword;
  int deptId;
  List<int> subjects;

  CreateTeacherModel({
    required this.name,
    required this.userName,
    required this.password,
    required this.confirmPassword,
    required this.deptId,
    required this.subjects,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'userName': userName,
      'password': password,
      'confirmPassword': confirmPassword,
      'deptId': deptId,
      'subjects': subjects,
    };
  }
}
