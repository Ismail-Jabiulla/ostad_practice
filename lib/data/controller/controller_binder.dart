import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:untitled/data/controller/task_delete_controller.dart';
import 'package:untitled/data/controller/task_manage/add_task_controller.dart';
import 'package:untitled/data/controller/task_manage/cancelled_controller.dart';
import 'package:untitled/data/controller/task_manage/complete_controller.dart';
import 'package:untitled/data/controller/language_controller.dart';
import 'package:untitled/data/controller/task_manage/new_task_list_controller.dart';
import 'package:untitled/data/controller/task_manage/task_count_controller.dart';
import 'package:untitled/data/controller/auth/profile_update_controller.dart';
import 'package:untitled/data/controller/task_manage/progress_controller.dart';
import 'package:untitled/data/controller/auth/signup_controller.dart';
import 'package:untitled/data/controller/task_update_controller.dart';
import 'package:untitled/data/controller/theme_controller.dart';
import 'auth/login_controller.dart';

class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => SignUpController());
    Get.lazyPut(() => ProfileUpdateController());
    Get.lazyPut(() => LanguageController());
    Get.lazyPut(() => ThemeController());
    Get.lazyPut(() => TaskListController());
    Get.lazyPut(() => CountStatusController());
    Get.lazyPut(() => AddTaskController());
    Get.lazyPut(() => CancelledController());
    Get.lazyPut(() => ProgressTaskController());
    Get.lazyPut(() => CompleteController());
    Get.lazyPut(() => TaskDeleteController());
    Get.lazyPut(() => TaskStatusUpdateController());
  }

}