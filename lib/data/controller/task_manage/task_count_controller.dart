import 'package:get/get.dart';
import 'package:untitled/data/model/count_status_model.dart';
import 'package:untitled/data/services/network_caller.dart';
import 'package:untitled/data/utility/app_url.dart';
import 'package:untitled/presentation/utiles/custom_snackbar.dart';

class CountStatusController extends GetxController {
  var countByStatusWrapper = CountByStatusWrapper();
  bool InProgress = false;

  @override
  void onInit() {
    getAllTaskCountByStatus();
    super.onInit();
  }
  Future<void> refreshDataTaskCount() async {
    await getAllTaskCountByStatus();
  }

  Future<void> getAllTaskCountByStatus() async {
    InProgress = true;
    update();
    final response = await NetworkCaller.getRequest(Urls.taskCountByStatus);
    if (response.isSuccess) {
      countByStatusWrapper =
          CountByStatusWrapper.fromJson(response.responseBody);
    } else {
      update();
      showSnackBarMessage(
        Get.context!,
        response.errorMessage ?? "Get Task Count By status has failed",
      );
    }
    InProgress = false;
    update();
  }
}
