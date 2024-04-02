import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/app_url.dart';

class TaskDeleteController extends GetxController {
  bool inProgress = false;
  String? deletingItemId;
  String? selectedItemId; // New state variable to track selected item ID

  // Method to set the selected item ID
  void setSelectedItemId(String? id) {
    selectedItemId = id;
    update();
  }

  Future<void> deleteTaskById(String id, VoidCallback refreshData) async {
    inProgress = true;
    deletingItemId = id;
    setSelectedItemId(id); // Set selected item before deletion
    update();

    final response = await NetworkCaller.getRequest(Urls.deleteTask(id));
    inProgress = false;
    deletingItemId = null;
    setSelectedItemId(null); // Reset selected item after deletion
    update();

    if (response.isSuccess) {
      refreshData();
    } else {
      // Handle error
    }
  }
}
