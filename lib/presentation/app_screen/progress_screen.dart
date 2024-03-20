import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/provider/language_provider.dart';
import '../utiles/custom_appbar.dart';
import 'authenication/profile_screen.dart';
import '../../data/model/task_list_wrapper.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/app_url.dart';
import '../utiles/card_item_widget.dart';
import '../utiles/custom_snackbar.dart';


class ProgressScreen extends StatefulWidget {
  const ProgressScreen({Key? key}) : super(key: key);

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  late bool _getProgressTaskListInProgress = false;
  late TaskListWrapper _progressTaskListWrapper = TaskListWrapper();

  @override
  void initState() {
    super.initState();
    _getAllProgressTaskList();
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 8),
                _buildItemUpdate(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItemUpdate() {
    return Visibility(

      visible: _progressTaskListWrapper.taskList?.isNotEmpty ?? false,
      replacement: Center(child: Text('No item')),

      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: _progressTaskListWrapper.taskList?.length ?? 0,
        shrinkWrap: true,
        primary: false,
        itemBuilder: (BuildContext context, index) {
          var languageProvider = Provider.of<LanguageProvider>(context);
          var currentLanguage = languageProvider.currentLanguage;
          return CardItemWidget(
            taskItem: _progressTaskListWrapper.taskList![index],
            refreshData: () {
              _refreshData();
            }, taskStatus: currentLanguage.process, taskStatusColor: Colors.green.shade800,
          );
        },
      ),
    );
  }

  Future<void> _refreshData() async {
    await _getAllProgressTaskList();
  }

  Future<void> _getAllProgressTaskList() async {
    _getProgressTaskListInProgress = true;
    setState(() {});
    final response = await NetworkCaller.getRequest(Urls.progressTaskList);

    print('Progress Task ${Urls.progressTaskList}');

    if (response.isSuccess) {
      _progressTaskListWrapper = TaskListWrapper.fromJson(response.responseBody);
      _getProgressTaskListInProgress = false;
      setState(() {});
    } else {
      _getProgressTaskListInProgress = false;
      setState(() {});
      showSnackBarMessage(
        context,
        response.errorMessage ?? 'Get complete task list has been failed',
      );
    }
    setState(() => _getProgressTaskListInProgress = false);
  }
}
