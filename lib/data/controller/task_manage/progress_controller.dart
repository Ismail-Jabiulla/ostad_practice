import 'package:get/get.dart';
import '../../model/task_list_wrapper.dart';
import '../../services/network_caller.dart';
import '../../utility/app_url.dart';

class ProgressTaskController extends GetxController {
  var _inProgress = false;
  bool get inProgress => _inProgress;

  var _progressTaskListWrapper = TaskListWrapper();
  TaskListWrapper get progressTaskListWrapper => _progressTaskListWrapper;

  Future<void> refreshData() async {
    await _getAllProgressTaskList();
  }

  Future<void> _getAllProgressTaskList() async {
    _inProgress = true;
    update();

    final response = await NetworkCaller.getRequest(Urls.progressTaskList);
    print('Progress Task ${Urls.progressTaskList}');

    if (response.isSuccess) {
      _progressTaskListWrapper = TaskListWrapper.fromJson(response.responseBody);
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
