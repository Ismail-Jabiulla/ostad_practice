import 'package:get/get.dart';
import '../../model/task_list_wrapper.dart';
import '../../services/network_caller.dart';
import '../../utility/app_url.dart';

class CompleteController extends GetxController {
  bool _inProgress = false;
  var completeTaskListWrapper = TaskListWrapper();

  bool get inProgress => _inProgress;

  @override
  void onInit() {
    super.onInit();
    getAllCompleteTaskList();
  }

  Future<void> refreshData() async {
    await getAllCompleteTaskList();
  }

  Future<void> getAllCompleteTaskList() async {
    _inProgress = true;
    update();
    final response = await NetworkCaller.getRequest(Urls.completedTaskList);

    if (response.isSuccess) {
      completeTaskListWrapper = TaskListWrapper.fromJson(response.responseBody);
    } else {
      update();
      Get.snackbar(
        'Error',
        response.errorMessage ?? 'Get complete task list has been failed',
      );
    }
    _inProgress = false;
    update();
  }
}
