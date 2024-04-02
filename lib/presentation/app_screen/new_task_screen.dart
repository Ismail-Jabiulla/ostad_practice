import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/data/controller/task_manage/new_task_list_controller.dart';
import 'package:untitled/data/controller/task_manage/task_count_controller.dart';
import 'package:untitled/localization/Language/languages.dart';
import 'package:untitled/presentation/utiles/card_item_widget.dart';
import '../../data/controller/language_controller.dart';
import '../utiles/custom_appbar.dart';
import '../utiles/task_card.dart';
import 'add_task_screen.dart';
import 'authenication/profile_screen.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({Key? key}) : super(key: key);

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {

  final CountStatusController _countStatusController = Get.put(CountStatusController());
  final TaskListController  _taskListController = Get.put(TaskListController());

  @override
  void initState() {
    super.initState();
    _countStatusController.refreshDataTaskCount;
    _taskListController.refreshDataTaskList;
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
        onRefresh: _countStatusController.refreshDataTaskCount,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              _buildTaskCount(context, currentLanguage),
              Expanded(
                flex: 8,
                child: Stack(
                  children: [
                    const SizedBox(height: 8),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          _buildItemUpdate(currentLanguage),
                          const SizedBox(height: 80),
                        ],
                      ),
                    ),
                    _buildFloatingActionButton(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTaskCount(BuildContext context, Languages currentLanguage) {
    return Expanded(
      flex: 1,
      child: GetBuilder<CountStatusController>(builder: (controller1){
        return Visibility(
          visible: controller1.InProgress == false,
          replacement: const Center(
            child: LinearProgressIndicator(),
          ),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: controller1.countByStatusWrapper.listOfTaskByStatusData?.length ?? 0,
            itemBuilder: (context, index) {
              return TaskCard(
                title: controller1.countByStatusWrapper.listOfTaskByStatusData![index].sId.toString(),
                value:
                controller1.countByStatusWrapper.listOfTaskByStatusData![index].sum ?? 0,
              );
            },
            separatorBuilder: (_, __) {
              return const SizedBox(width: 8);
            },
          ),
        );
      })
    );
  }

  Widget _buildItemUpdate(currentLanguage) {
    return GetBuilder<TaskListController>(builder: (controller2){
      return Visibility(
        visible: controller2.inProgress == false,
        replacement: Center(child: Text('No item')),

        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: controller2.newTaskListWrapper.taskList?.length ?? 0,
          shrinkWrap: true,
          primary: false,
          itemBuilder: (BuildContext context, index) {
            return CardItemWidget(
              taskItem: controller2.newTaskListWrapper.taskList![index],
              refreshData: _taskListController.refreshDataTaskList,
              taskStatus: currentLanguage.newT, taskStatusColor: Colors.blue.shade800,
            );
          },
        ),
      );
    });
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return Positioned(
      right: 5.0,
      bottom: 16.0,
      child: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNewTaskScreen(),
            ),
          ).then((result) {
            _countStatusController.refreshDataTaskCount;
          });
        },
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.onSecondary,
        ),
      ),
    );
  }
   
}
