class PaperCodeNameModel {
  int? id;
 final  String subjectIdName;

  PaperCodeNameModel({
    required this.id,
    required this.subjectIdName,
  });

  factory PaperCodeNameModel.fromJson(Map<String, dynamic> json) {
    return PaperCodeNameModel(
      id: json['id'],
      subjectIdName: json['subjectIdName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'subjectIdName': subjectIdName,
    };
  }
}
