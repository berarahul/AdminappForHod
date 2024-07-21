class TeacherModel {
   int? teacherId;
   String? name;

  TeacherModel({required this.teacherId, required this.name});

  factory TeacherModel.fromJson(Map<String, dynamic> json) {
    return TeacherModel(
      teacherId: json['teacherId'],
      name: json['name'],
    );
  }
}
