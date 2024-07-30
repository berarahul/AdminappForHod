import 'package:get_storage/get_storage.dart';

class Routinecardapi{

  Routinecardapi._();
  static const String baseurl = "https://attendancesystem-s1.onrender.com";
// For AddClass
  static const String addClassEndPoint = "/api/classRoutine/addClass";

  // For UpdateRoutine
static const String updateRoutine = "classRoutine/updateRoutine";

//For RemoveClass
static const String removeClass = "classRoutine/deleteRoutine";



  static String get AllDepartmentApiUrl{

    return "$baseurl/api/dept/all";
  }
  static String get fetchRoutine{
    final storage = GetStorage();
    int? deptId = storage.read('selectedDepartmentId');
    int? semId = storage.read('selectedSemesterId');

    print(deptId);
    print(semId);
    if (deptId != null && semId != null) {
      return "$baseurl/api/classRoutine/getRoutine?deptId=$deptId&sem=$semId";

    } else {
      return "$baseurl/api/classRoutine/getRoutine?deptId=1&sem=1"; // default or handle error
    }
  }


}