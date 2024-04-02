import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../services/network_caller.dart';
import '../../utility/app_url.dart';

class AddTaskController extends GetxController {

  bool _inProgress = false;
  final subjectController = TextEditingController();
  final descriptionController = TextEditingController();
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  bool get inProgress => _inProgress;

  Future<void> addNewTask() async {
    _inProgress = true;
    update();

    Map<String, dynamic> inputParams = {
      "title": subjectController.text.trim(),
      "description": descriptionController.text.trim(),
      "status": "New"
    };

    final response = await NetworkCaller.postRequest(Urls.createTask, inputParams);

    _inProgress = false;
    update();

    if (response.isSuccess) {
      subjectController.clear();
      descriptionController.clear();
      if (Get.isSnackbarOpen != true) {
        Get.snackbar('Success', 'New task has been added!');
      }
    } else {
      Get.snackbar('Error', response.errorMessage ?? 'Add new task failed!');
      update();
    }
  }
}
