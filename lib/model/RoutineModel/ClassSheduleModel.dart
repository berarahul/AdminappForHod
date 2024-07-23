// // models/schedule.dart
//
// class Schedule {
//   late  String day;
//   late  int id;
//   late final String subName;
//   late  String roomName;
//   late final String teacherName;
//   late final String paperCode;
//   late   String startingTime;
//   late   String endingTime;
//   late  int subjectId; // Added
//   late  int teacherId; // Added
//
//   Schedule({
//     required this.subName,
//     required this.roomName,
//     required this.teacherName,
//     required this.paperCode,
//     required this.startingTime,
//     required this.endingTime,
//     required this.subjectId, // Added
//     required this.teacherId, // Added
//     required this.id, // Added
//     required this.day, // Added
//   });
//
//   factory Schedule.fromJson(Map<String, dynamic> json) {
//     return Schedule(
//       subName: json['subName'],
//       roomName: json['roomName'],
//       teacherName: json['teacherName'],
//       paperCode: json['paperCode'],
//       startingTime: json['startingTime'],
//       endingTime: json['endingTime'],
//       teacherId: json['teacherId'],
//       subjectId: json['subjectId'], // Added
//       id: json['id'], // Added
//       day: json['day'], // Added
//     );
//   }
// }
//



class Schedule {
  late String day;
  late  int id;
  late final String subName;
  late String roomName;
  late final String teacherName;
  late final String paperCode;
  late String startingTime;
  late String endingTime;
  late int subjectId;
  late int teacherId;

  Schedule({
    required this.subName,
    required this.roomName,
    required this.teacherName,
    required this.paperCode,
    required this.startingTime,
    required this.endingTime,
    required this.subjectId,
    required this.teacherId,
    required this.id,
    required this.day,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      subName: json['subName'] ?? '',
      roomName: json['roomName'] ?? '',
      teacherName: json['teacherName'] ?? '',
      paperCode: json['paperCode'] ?? '',
      startingTime: json['startingTime'] ?? '',
      endingTime: json['endingTime'] ?? '',
      subjectId: json['subjectId'] ?? 0,
      teacherId: json['teacherId'] ?? 0,
      id: json['id'] ?? 0,
      day: json['day'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subName': subName,
      'roomName': roomName,
      'teacherName': teacherName,
      'paperCode': paperCode,
      'startingTime': startingTime,
      'endingTime': endingTime,
      'subjectId': subjectId,
      'teacherId': teacherId,
      'id': id,
      'day': day,
    };
  }
}
