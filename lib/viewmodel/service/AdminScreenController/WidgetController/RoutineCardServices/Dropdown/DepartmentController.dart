import 'package:attendanceadmin/viewmodel/service/LoginService/AutharizationHeader.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../../../model/universalmodel/departmentModel.dart';


class DepartmentController extends GetxController {
  var isLoading = true.obs;
  var departmentList = <DepartmentModel>[].obs;
  var selectedDepartmentId = 0.obs;
  final storage = GetStorage();

  @override
  void onInit() {
    fetchDepartments();
    selectedDepartmentId.value = storage.read('selectedDepartmentId') ?? 0;
    super.onInit();
  }

  void fetchDepartments() async {
    try {
      isLoading(true);
      var departments = await ApiHelper().fetchDepartments();
      if (departments != null) {
        departmentList.value = departments;
      }
    } finally {
      isLoading(false);
    }
  }

  void selectDepartment(int id) {
    selectedDepartmentId.value = id;
    storage.write('selectedDepartmentId', id);
    print('Selected Department ID: $id has been stored.');
  }
  void cleardepartmentlist(){
    departmentList.clear();
  }
}
