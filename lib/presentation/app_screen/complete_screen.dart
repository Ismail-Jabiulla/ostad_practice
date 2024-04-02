import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/data/controller/task_manage/complete_controller.dart';
import 'package:untitled/presentation/utiles/card_item_widget.dart';
import '../../data/controller/language_controller.dart';
import '../utiles/custom_appbar.dart';
import 'authenication/profile_screen.dart';

class CompleteScreen extends StatefulWidget {
  const CompleteScreen({Key? key}) : super(key: key);

  @override
  State<CompleteScreen> createState() => _CompleteScreenState();
}

class _CompleteScreenState extends State<CompleteScreen> {
  final CompleteController _controller = Get.put(CompleteController());

  @override
  void initState() {
    super.initState();
    _controller.getAllCompleteTaskList();
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
        onRefresh: _controller.refreshData,
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
    return GetBuilder<CompleteController>(
      builder: (controller) {
        return Visibility(
          visible:
              controller.completeTaskListWrapper.taskList?.isNotEmpty ?? false,
          replacement: const Center(child: Text('No item')),
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount:
                controller.completeTaskListWrapper.taskList?.length ?? 0,
            shrinkWrap: true,
            primary: false,
            itemBuilder: (BuildContext context, index) {
              return CardItemWidget(
                taskItem: controller.completeTaskListWrapper.taskList![index],
                refreshData: () {
                  controller.refreshData();
                },
                taskStatus: currentLanguage.complete,
                taskStatusColor: Colors.purple.shade800,
              );
            },
          ),
        );
      },
    );
  }
}
