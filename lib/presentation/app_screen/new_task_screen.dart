import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/data/services/network_caller.dart';
import 'package:untitled/data/utility/app_url.dart';
import 'package:untitled/localization/Language/languages.dart';
import 'package:untitled/presentation/utiles/card_item_widget.dart';
import 'package:untitled/presentation/utiles/custom_snackbar.dart';
import '../../data/model/task_list_wrapper.dart';
import '../../data/provider/language_provider.dart';
import '../utiles/custom_appbar.dart';
import '../utiles/task_card.dart';
import 'add_task_screen.dart';
import 'authenication/profile_screen.dart';
import '../../data/model/count_status_model.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({Key? key}) : super(key: key);

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  late bool _getAllTaskCountByStatusInProgress = false;
  late bool _getTaskListInProgress = false;
  late CountByStatusWrapper _countByStatusWrapper = CountByStatusWrapper();
  late TaskListWrapper _newTaskListWrapper = TaskListWrapper();

  @override
  void initState() {
    super.initState();
    _getAllTaskCountByStatus();
    _getAllNewTaskList();
  }

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    var currentLanguage = languageProvider.currentLanguage;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: CustomAppBar(
        callBack: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ProfileScreen()));
        },
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
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
                          _buildItemUpdate(),
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
      child: Visibility(
        visible: !_getAllTaskCountByStatusInProgress,
        replacement: const Center(
          child: LinearProgressIndicator(),
        ),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: _countByStatusWrapper.listOfTaskByStatusData?.length ?? 0,
          itemBuilder: (context, index) {
            return TaskCard(
              title: _countByStatusWrapper.listOfTaskByStatusData![index].sId.toString(),
              value:
                  _countByStatusWrapper.listOfTaskByStatusData![index].sum ?? 0,
            );
          },
          separatorBuilder: (_, __) {
            return const SizedBox(width: 8);
          },
        ),
      ),
    );
  }

  Widget _buildItemUpdate() {
    return Visibility(
      visible: _newTaskListWrapper.taskList?.isNotEmpty ?? false,
      replacement: Center(child: Text('No item')),

      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: _newTaskListWrapper.taskList?.length ?? 0,
        shrinkWrap: true,
        primary: false,
        itemBuilder: (BuildContext context, index) {
          var languageProvider = Provider.of<LanguageProvider>(context);
          var currentLanguage = languageProvider.currentLanguage;
          return CardItemWidget(
            taskItem: _newTaskListWrapper.taskList![index],
            refreshData: () {
              _refreshData();
            }, taskStatus: currentLanguage.newT, taskStatusColor: Colors.blue.shade800,
          );
        },
      ),
    );
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
            _refreshData();
          });
        },
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.onSecondary,
        ),
      ),
    );
  }

  Future<void> _refreshData() async {
    await _getAllTaskCountByStatus();
    await _getAllNewTaskList();
  }

  Future<void> _getAllTaskCountByStatus() async {
    setState(() => _getAllTaskCountByStatusInProgress = true);
    final response = await NetworkCaller.getRequest(Urls.taskCountByStatus);
    if (response.isSuccess) {
      _countByStatusWrapper =
          CountByStatusWrapper.fromJson(response.responseBody);
    } else {
      showSnackBarMessage(
        context,
        response.errorMessage ?? "Get Task Count By status has failed",
      );
    }
    setState(() => _getAllTaskCountByStatusInProgress = false);
  }

  Future<void> _getAllNewTaskList() async {
    _getTaskListInProgress = true;
    setState(() {});
    final response = await NetworkCaller.getRequest(Urls.newTaskList);

    if (response.isSuccess) {
      _newTaskListWrapper = TaskListWrapper.fromJson(response.responseBody);
    } else {
      showSnackBarMessage(
        context,
        response.errorMessage ?? 'Get new task list has been failed',
      );
    }
    setState(() => _getTaskListInProgress = false);
  }
}
