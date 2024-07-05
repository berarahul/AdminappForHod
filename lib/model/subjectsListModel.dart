class Subjectslistmodel {
  String departmentName;
  List<Subject> subjects;

  Subjectslistmodel({
    required this.departmentName,
    required this.subjects,
  });

}

class Subject {
  int id;
  String subName;
  int deptId;
  int semesterId;
  int subjectId;

  Subject({
    required this.id,
    required this.subName,
    required this.deptId,
    required this.semesterId,
    required this.subjectId,
  });

}
