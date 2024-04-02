import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/controller/bottom_nav_controller.dart';
import '../../data/controller/task_delete_controller.dart';
import '../../data/controller/task_update_controller.dart';
import '../../data/model/task_tem.dart';
import '../../data/controller/language_controller.dart';

class CardItemWidget extends StatefulWidget {
  final TaskItem taskItem;
  final VoidCallback refreshData;
  final String taskStatus;
  final Color taskStatusColor;

  const CardItemWidget(
      {Key? key,
      required this.taskItem,
      required this.refreshData,
      required this.taskStatus,
      required this.taskStatusColor})
      : super(key: key);

  @override
  State<CardItemWidget> createState() => _CardItemWidgetState();
}

class _CardItemWidgetState extends State<CardItemWidget> {
  final TaskDeleteController _deleteController =
      Get.put(TaskDeleteController());
  final TaskStatusUpdateController _updateController =
      Get.put(TaskStatusUpdateController());
  final BottomNavigationController _controller = Get.put(BottomNavigationController());

  @override
  Widget build(BuildContext context) {
    var languageController = Get.find<LanguageController>();
    var currentLanguage = languageController.currentLanguage;

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
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                  GetBuilder<TaskStatusUpdateController>(
                    builder: (controller) {
                      return Visibility(
                        visible: !controller.inProgress,
                        // Only show if not in progress
                        replacement: controller.selectedItemId ==
                                widget.taskItem.sId
                            ? const CircularProgressIndicator(
                                color: Colors
                                    .green)
                            : IconButton(
                          icon: Icon(
                            Icons.edit_note,
                            color: Colors.green.shade900,
                            size: 20,
                          ),
                          onPressed: () {
                            controller.setSelectedItemId(widget.taskItem.sId!);
                            _showUpdateStatusDialog(widget.taskItem.sId!, _controller.selectedIndex.value);
                          },
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.edit_note,
                            color: Colors.green.shade900,
                            size: 20,
                          ),
                          onPressed: () {
                            controller.setSelectedItemId(widget.taskItem.sId!);
                            _showUpdateStatusDialog(widget.taskItem.sId!, _controller.selectedIndex.value);
                          },
                        ),
                      );
                    },
                  ),
                  GetBuilder<TaskDeleteController>(builder: (deleteController) {
                    return Visibility(
                      visible: !deleteController.inProgress,
                      replacement: deleteController.selectedItemId ==
                              widget.taskItem.sId
                          ? const CircularProgressIndicator(color: Colors.green)
                          : IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red.shade900,
                                size: 20,
                              ),
                              onPressed: () {
                                deleteController
                                    .setSelectedItemId(widget.taskItem.sId!);
                                deleteController.deleteTaskById(
                                    widget.taskItem.sId!, widget.refreshData);
                              },
                            ),
                      child: IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red.shade900,
                          size: 20,
                        ),
                        onPressed: () {
                          deleteController
                              .setSelectedItemId(widget.taskItem.sId!);
                          deleteController.deleteTaskById(
                              widget.taskItem.sId!, widget.refreshData);
                        },
                      ),
                    );
                  })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showUpdateStatusDialog(sId, int bottomNavIndex) {
    bool isNewSelected = bottomNavIndex == 0;
    bool isCompletedSelected = bottomNavIndex == 1;
    bool isCancelledSelected = bottomNavIndex == 2;
    bool isProgressSelected = bottomNavIndex == 3;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Status'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('New', style: TextStyle(color: Colors.black87)),
                trailing: isNewSelected
                    ? const Icon(
                  Icons.check,
                  color: Colors.black87,
                )
                    : null,
                onTap: () {
                  isNewSelected ? null: _updateController.updateTaskById(sId, 'New', widget.refreshData);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Completed',
                    style: TextStyle(color: Colors.black87)),
                trailing: isCompletedSelected
                    ? const Icon(
                  Icons.check,
                  color: Colors.black87,
                )
                    : null,
                onTap: () {
                  isCompletedSelected ? null : _updateController.updateTaskById(
                      sId, 'Completed', widget.refreshData);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Cancelled',
                    style: TextStyle(color: Colors.black87)),
                trailing: isCancelledSelected
                    ? const Icon(
                  Icons.check,
                  color: Colors.black87,
                )
                    : null,
                onTap: () {
                  isCancelledSelected ? null : _updateController.updateTaskById(
                      sId, 'Cancelled', widget.refreshData);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Progress',
                    style: TextStyle(color: Colors.black87)),
                trailing: isProgressSelected
                    ? const Icon(
                  Icons.check,
                  color: Colors.black87,
                )
                    : null,
                onTap: () {
                  isProgressSelected ? null : _updateController.updateTaskById(
                      sId, 'Progress', widget.refreshData);
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
