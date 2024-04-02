import 'package:get/get.dart';
import '../../model/task_list_wrapper.dart';
import '../../services/network_caller.dart';
import '../../utility/app_url.dart';

class CancelledController extends GetxController {
  var _inProgress = false;
  bool get inProgress => _inProgress;

  var _cancelledTaskListWrapper = TaskListWrapper();
  TaskListWrapper get cancelledTaskListWrapper => _cancelledTaskListWrapper;

  Future<void> refreshData() async {
    await _getAllCancelledTaskList();
  }

  Future<void> _getAllCancelledTaskList() async {
    _inProgress = true;
    update();
    final response = await NetworkCaller.getRequest(Urls.cancelledTaskList);
    print('cancelled Task ${Urls.cancelledTaskList}');

    if (response.isSuccess) {
      _cancelledTaskListWrapper = TaskListWrapper.fromJson(response.responseBody);
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
