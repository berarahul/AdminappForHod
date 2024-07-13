class Subjectslistmodel {
  String? departmentName;
  List<SubjectModel>? subjects;

  Subjectslistmodel({
    this.departmentName,
    this.subjects,
  });

  factory Subjectslistmodel.fromJson(Map<String, dynamic> json) {
    return Subjectslistmodel(
      departmentName: json['departmentName'],
      subjects:
          List<SubjectModel>.from(json['subjects'].map((x) => SubjectModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'departmentName': departmentName,
      'subjects': subjects!.map((x) => x.toJson()).toList(),
    };
  }
}
//
class SubjectModel {
  int? id;
 String? subName;
  int? deptId;
  int? semesterId;
  int? paperId;
 String? paperName;
  SubjectModel({
    this.id,
    this.subName,
    this.deptId,
    this.semesterId,
    this.paperId,
    this.paperName

  });

  factory SubjectModel.fromJson(Map<String, dynamic> json) {
    return SubjectModel(
      id: json['id'],
      subName: json['subName'],
      deptId: json['deptId'],
      semesterId: json['semesterId'],
      paperId: json['paperId'],
      paperName: json['paperName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'subName': subName,
      'deptId': deptId,
      'semesterId': semesterId,
      'paperId': paperId,
      'paperName': paperName
    };
  }
}





