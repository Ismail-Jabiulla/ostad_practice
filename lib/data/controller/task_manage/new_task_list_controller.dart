import 'package:get/get.dart';
import 'package:untitled/data/model/task_list_wrapper.dart';
import 'package:untitled/data/services/network_caller.dart';
import 'package:untitled/data/utility/app_url.dart';
import 'package:untitled/presentation/utiles/custom_snackbar.dart';

class TaskListController extends GetxController {
  var newTaskListWrapper = TaskListWrapper();
  var inProgress = false;

  @override
  void onInit() {
    getAllNewTaskList();
    super.onInit();
  }
  Future<void> refreshDataTaskList() async {
    await getAllNewTaskList();
  }
  Future<void> getAllNewTaskList() async {
    inProgress= true;
    update();
    final response = await NetworkCaller.getRequest(Urls.newTaskList);

    if (response.isSuccess) {
      newTaskListWrapper =
          TaskListWrapper.fromJson(response.responseBody);
    } else {
      update();
      showSnackBarMessage(
        Get.context!,
        response.errorMessage ?? 'Get new task list has been failed',
      );
    }
    inProgress = false;
    update();
  }
}
