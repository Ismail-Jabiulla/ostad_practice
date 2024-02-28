import 'package:flutter/material.dart';
import 'package:untitled/presentation/constant/image_constants.dart';

import '../utiles/custom_appbar.dart';
import 'add_task_screen.dart';

class NewTaskScreen extends StatelessWidget {
  const NewTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: Column(
          children: [
            _taskCount(context),
            Expanded(
              child: Stack(
                children: [
                  const SizedBox(height: 8),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        _itemUpdate(),
                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 5.0,
                    bottom: 16.0,
                    child: FloatingActionButton(
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const AddNewTaskScreen()));
                      },
                      child: Icon(
                        Icons.add,
                        color: Theme.of(context).colorScheme.onSecondary,
                        //color: Colors.white,
                      ),
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

  Widget _taskCount(context) {
    return Container(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Column(
              children: [
                Text(
                  '09',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary),
                ),
                Text(
                  'Cancelled',
                  style: TextStyle(
                      fontSize: 10,
                      color: Theme.of(context).colorScheme.secondary),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Column(
              children: [
                Text(
                  '09',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary),
                ),
                Text(
                  'Completed',
                  style: TextStyle(
                      fontSize: 10,
                      color: Theme.of(context).colorScheme.secondary),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Column(
              children: [
                Text(
                  '09',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary),
                ),
                Text(
                  'Processing',
                  style: TextStyle(
                      fontSize: 10,
                      color: Theme.of(context).colorScheme.secondary),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Column(
              children: [
                Text(
                  '09',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary),
                ),
                Text(
                  'New Task',
                  style: TextStyle(
                      fontSize: 10,
                      color: Theme.of(context).colorScheme.secondary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemUpdate() {
    return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: 10,
        shrinkWrap: true,
        primary: false,
        itemBuilder: (BuildContext context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
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
                        ///title
                        Text(
                          'Navigate highs and lows, turning crises into emotional resilience.',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.secondary),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),

                        ///sub title
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Text(
                            'Mauris consectetur tortor ac nulla consequat, sit amet eleifend orci rutrum. Sed pharetra magna ut justo rhoncus feugiat.',
                            style: TextStyle(
                                fontSize: 10,
                                color: Theme.of(context).colorScheme.secondary),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            'Date: 02/06/2024',
                            style: TextStyle(
                                fontSize: 10,
                                color: Theme.of(context).colorScheme.secondary),
                          ),
                        ),

                        ///now
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.blue.shade800,
                            ),
                            child: Text(
                              'Now',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.onSecondary
                                  //color: Colors.white),
                                  ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  ///delete and edit
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(
                            Icons.edit_note,
                            color: Colors.green.shade900,
                            size: 20,
                          ),
                          Icon(
                            Icons.delete,
                            color: Colors.red.shade900,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
