import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/model/task_tem.dart';
import '../../data/provider/language_provider.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/app_url.dart';
import 'custom_snackbar.dart';
import 'ontap_alert_dialog.dart';

class CardItemWidget extends StatefulWidget {

  final TaskItem taskItem;
  final VoidCallback refreshData;
  final String taskStatus;
  final Color taskStatusColor;

  const CardItemWidget({Key? key, required this.taskItem, required this.refreshData, required this.taskStatus, required this.taskStatusColor}) : super(key: key);

  @override
  State<CardItemWidget> createState() => _CardItemWidgetState();
}

class _CardItemWidgetState extends State<CardItemWidget> {

  late bool _deleteTaskInProgress = false;
  late bool _updateTaskStatusInProgress = false;

  @override
  Widget build(BuildContext context) {

    var languageProvider = Provider.of<LanguageProvider>(context);
    var currentLanguage = languageProvider.currentLanguage;

    return Card(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.taskItem.title ?? '',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      widget.taskItem.description ?? '',
                      style: TextStyle(
                        fontSize: 10,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      '${currentLanguage.date}: ${widget.taskItem.createdDate}',
                      style: TextStyle(
                        fontSize: 10,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: widget.taskStatusColor,
                      ),
                      child: Text(
                        widget.taskStatus,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [

                  Visibility(
                    visible: _updateTaskStatusInProgress == false,
                    replacement: const CircularProgressIndicator(color: Colors.green),
                    child: IconButton(
                      icon: Icon(
                        Icons.edit_note,
                        color: Colors.green.shade900,
                        size: 20,
                      ),
                      onPressed: (){
                        _showUpdateStatusDialog(widget.taskItem.sId!);
                      },
                    ),
                  ),

                  Visibility(
                    visible: _deleteTaskInProgress == false,
                    replacement: const CircularProgressIndicator(color: Colors.green),
                    child: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red.shade900,
                        size: 20,
                      ),
                      onPressed: (){
                        _deleteTaskById(widget.taskItem.sId!);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _deleteTaskById(String id) async {
    _deleteTaskInProgress = true;
    setState(() {});

    final response = await NetworkCaller.getRequest(Urls.deleteTask(id));
    _deleteTaskInProgress = false;

    if (response.isSuccess) {
      widget.refreshData();
    } else {
      setState(() {});
      if (mounted) {
        showSnackBarMessage(
          context,
          response.errorMessage ?? 'Delete task list has been failed',
        );
      }
    }
  }

  Future<void> _updateTaskById(String id, String status) async {
    _updateTaskStatusInProgress = true;
    setState(() {});

    final response =
    await NetworkCaller.getRequest(Urls.updateTaskStatus(id, status));
    _updateTaskStatusInProgress = false;

    if (response.isSuccess) {
      widget.refreshData();
    } else {
      setState(() {});
      if (mounted) {
        showSnackBarMessage(
          context,
          response.errorMessage ?? 'Update task has been failed',
        );
      }
    }
  }

  void _showUpdateStatusDialog(sId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Status'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ListTile(
                title: Text('New', style: TextStyle(color: Colors.black87)),
                trailing: Icon(
                  Icons.check,
                  color: Colors.black87,
                ),
              ),
              ListTile(
                title: const Text('Completed',
                    style: TextStyle(color: Colors.black87)),
                onTap: () {
                  _updateTaskById(sId, 'Completed');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Cancelled',
                    style: TextStyle(color: Colors.black87)),
                onTap: () {
                  _updateTaskById(sId, 'Cancelled');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Progress',
                    style: TextStyle(color: Colors.black87)),
                onTap: () {
                  _updateTaskById(sId, 'Progress');
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
