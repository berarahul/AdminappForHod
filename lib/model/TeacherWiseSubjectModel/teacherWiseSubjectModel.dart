class TeacherwiseSubjectModel {
  int subjectId;
  int semester;
  String subjectName;

  TeacherwiseSubjectModel({
    required this.subjectId,
    required this.semester,
    required this.subjectName,
  });

  // Factory method to create a SubjectModel from JSON
  factory TeacherwiseSubjectModel.fromJson(Map<String, dynamic> json) {
    return TeacherwiseSubjectModel(
      subjectId: json['subjectId'],
      semester: json['semester'],
      subjectName: json['subjectName'],
    );
  }

  // Method to convert a SubjectModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'subjectId': subjectId,
      'semester': semester,
      'subjectName': subjectName,
    };
  }
}
