import 'package:get/get.dart';

import '../../../../../../model/subjectModel.dart';


class RemoveSubjectController extends GetxController {
  var subjects = <Subject>[
    Subject(id: 1, name: 'Maths', semesterId: 1),
    Subject(id: 2, name: 'Science', semesterId: 1),
    Subject(id: 3, name: 'History', semesterId: 2),
    Subject(id: 4, name: 'Geography', semesterId: 2),
    Subject(id: 5, name: 'Physics', semesterId: 3),
    Subject(id: 6, name: 'Chemistry', semesterId: 3),
  ].obs;

  var selectedSemester = RxInt(0);

  List<Subject> get filteredSubjects {
    return subjects.where((subject) => subject.semesterId == selectedSemester.value).toList();
  }

  void removeSubject(int id) {
    subjects.removeWhere((subject) => subject.id == id);
  }
}
