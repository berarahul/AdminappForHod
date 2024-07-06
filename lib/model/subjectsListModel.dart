class Subjectslistmodel {
  String? departmentName;
  List<Subject>? subjects;

  Subjectslistmodel({
    this.departmentName,
    this.subjects,
  });

  factory Subjectslistmodel.fromJson(Map<String, dynamic> json) {
    return Subjectslistmodel(
      departmentName: json['departmentName'],
      subjects:
          List<Subject>.from(json['subjects'].map((x) => Subject.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'departmentName': departmentName,
      'subjects': subjects!.map((x) => x.toJson()).toList(),
    };
  }
}

class Subject {
  int? id;
  String? subName;
  int? deptId;
  int? semesterId;
  int? subjectId;

  Subject({
    this.id,
    this.subName,
    this.deptId,
    this.semesterId,
    this.subjectId,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['id'],
      subName: json['subName'],
      deptId: json['deptId'],
      semesterId: json['semesterId'],
      subjectId: json['subjectId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'subName': subName,
      'deptId': deptId,
      'semesterId': semesterId,
      'subjectId': subjectId,
    };
  }
}
