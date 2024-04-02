import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/data/controller/task_manage/progress_controller.dart';
import '../../data/controller/language_controller.dart';
import '../utiles/custom_appbar.dart';
import 'authenication/profile_screen.dart';
import '../utiles/card_item_widget.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({Key? key}) : super(key: key);

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  final ProgressTaskController _controller = Get.put(ProgressTaskController());

  @override
  void initState() {
    super.initState();
    _controller.refreshData();
  }

  @override
  Widget build(BuildContext context) {
    var languageController = Get.find<LanguageController>();
    var currentLanguage = languageController.currentLanguage;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: CustomAppBar(
        callBack: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ProfileScreen()));
        },
      ),
      body: RefreshIndicator(
        onRefresh:_controller.refreshData,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 8),
                _buildItemUpdate(currentLanguage),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItemUpdate(currentLanguage) {
    return GetBuilder<ProgressTaskController>(
      builder: (controller) {
        print(controller.progressTaskListWrapper.taskList?.length ?? 0);
        return Visibility(
          visible: controller.progressTaskListWrapper.taskList?.isNotEmpty ?? false,
          replacement: const Center(child: Text('No item',)),
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: controller.progressTaskListWrapper.taskList?.length ?? 0,
            shrinkWrap: true,
            primary: false,
            itemBuilder: (BuildContext context, index) {
              return CardItemWidget(
                taskItem: controller.progressTaskListWrapper.taskList![index],
                refreshData: _controller.refreshData,
                taskStatus: currentLanguage.process,
                taskStatusColor: Colors.green.shade800,
              );
            },
          ),
        );
      },
    );
  }
}
