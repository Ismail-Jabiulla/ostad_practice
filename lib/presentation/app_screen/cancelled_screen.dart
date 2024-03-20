import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/model/task_list_wrapper.dart';
import '../../data/provider/language_provider.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/app_url.dart';
import '../utiles/card_item_widget.dart';
import '../utiles/custom_appbar.dart';
import '../utiles/custom_snackbar.dart';
import 'authenication/profile_screen.dart';


class CancelledScreen extends StatefulWidget {
  const CancelledScreen({Key? key}) : super(key: key);

  @override
  State<CancelledScreen> createState() => _CancelledScreenState();
}

class _CancelledScreenState extends State<CancelledScreen> {
  late bool _getCancelledTaskListInProgress = false;
  late TaskListWrapper _cancelledTaskListWrapper = TaskListWrapper();

  @override
  void initState() {
    super.initState();
    _refreshData();
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
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
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

      visible: _cancelledTaskListWrapper.taskList?.isNotEmpty ?? false,
      replacement: Center(child: Text('No item')),

      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: _cancelledTaskListWrapper.taskList?.length ?? 0,
        shrinkWrap: true,
        primary: false,
        itemBuilder: (BuildContext context, index) {

          var languageProvider = Provider.of<LanguageProvider>(context);
          var currentLanguage = languageProvider.currentLanguage;

          return CardItemWidget(
            taskItem: _cancelledTaskListWrapper.taskList![index],
            refreshData: () {
              _refreshData();
            }, taskStatus: currentLanguage.cancelled, taskStatusColor: Colors.red.shade800,
          );
        },
      ),
    );
  }

  Future<void> _refreshData() async {
    await _getAllCancelledTaskList();
  }

  Future<void> _getAllCancelledTaskList() async {
    _getCancelledTaskListInProgress = true;
    setState(() {});
    final response = await NetworkCaller.getRequest(Urls.cancelledTaskList);

    print('cancelled Task ${Urls.cancelledTaskList}');

    if (response.isSuccess) {
      _cancelledTaskListWrapper = TaskListWrapper.fromJson(response.responseBody);

      _getCancelledTaskListInProgress = false;
      setState(() {});
    } else {
      _getCancelledTaskListInProgress = false;
      setState(() {});
      showSnackBarMessage(
        context,
        response.errorMessage ?? 'Get complete task list has been failed',
      );
    }
    setState(() => _getCancelledTaskListInProgress = false);
  }
}