import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/app_url.dart';

class TaskStatusUpdateController extends GetxController {
  bool inProgress = false;
  String? selectedItemId; // New state variable to track selected item ID

  // Method to set the selected item ID
  void setSelectedItemId(String? id) {
    selectedItemId = id;
    update();
  }

  Future<void> updateTaskById(String id, String status, VoidCallback refreshData) async {
    inProgress = true;
    setSelectedItemId(id); // Set selected item before updating
    update();

    final response = await NetworkCaller.getRequest(Urls.updateTaskStatus(id, status));
    inProgress = false;
    setSelectedItemId(null); // Reset selected item after update
    update();

    if (response.isSuccess) {
      refreshData();
    } else {
      // Handle error
    }
  }
}
