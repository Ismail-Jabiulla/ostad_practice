import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/data/controller/task_manage/cancelled_controller.dart';
import '../../data/controller/language_controller.dart';
import '../utiles/card_item_widget.dart';
import '../utiles/custom_appbar.dart';
import 'authenication/profile_screen.dart';

class CancelledScreen extends StatefulWidget {
  const CancelledScreen({Key? key}) : super(key: key);

  @override
  State<CancelledScreen> createState() => _CancelledScreenState();
}

class _CancelledScreenState extends State<CancelledScreen> {
  final CancelledController _controller = Get.put(CancelledController());

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
    return GetBuilder<CancelledController>(builder: (controller){
      return Visibility(
        visible: controller.cancelledTaskListWrapper.taskList?.isNotEmpty ?? false,
        replacement: const Center(child: Text('No item')),
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: controller.cancelledTaskListWrapper.taskList?.length ?? 0,
          shrinkWrap: true,
          primary: false,
          itemBuilder: (BuildContext context, index) {
            return CardItemWidget(
              taskItem: controller.cancelledTaskListWrapper.taskList![index],
              refreshData: () {
                controller.refreshData();
              },
              taskStatus: currentLanguage.cancelled,
              taskStatusColor: Colors.red.shade800,
            );
          },
        ),
      );
    });
  }
}
