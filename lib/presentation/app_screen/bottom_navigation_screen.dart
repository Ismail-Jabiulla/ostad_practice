import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/presentation/app_screen/new_task_screen.dart';
import 'package:untitled/presentation/app_screen/progress_screen.dart';
import '../../data/controller/bottom_nav_controller.dart';
import '../../data/controller/language_controller.dart';
import 'cancelled_screen.dart';
import 'complete_screen.dart';


class BottomNavigationScreen extends StatelessWidget {
  final BottomNavigationController _controller = Get.put(BottomNavigationController());

  @override
  Widget build(BuildContext context) {
    var languageController = Get.find<LanguageController>();
    var currentLanguage = languageController.currentLanguage;

    return Scaffold(
      body: Obx(() => IndexedStack(
        index: _controller.selectedIndex.value,
        children: const [
          NewTaskScreen(),
          CompleteScreen(),
          CancelledScreen(),
          ProgressScreen(),
        ],
      )),
      bottomNavigationBar: Container(
        height: 70,
        color: Theme.of(context).colorScheme.primary,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(Icons.add_task, currentLanguage.task, 0),

            _buildNavItem(Icons.done, currentLanguage.complete, 1),

            _buildNavItem(Icons.cancel_outlined, currentLanguage.cancelled, 2),

            _buildNavItem(Icons.incomplete_circle, currentLanguage.process, 3),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () {
        _controller.changeIndex(index);
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Obx(() => Column(
          children: [
            Icon(
              icon,
              color: _controller.selectedIndex.value == index
                  ? Colors.green.shade600
                  : Theme.of(Get.context!).colorScheme.secondary,
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: _controller.selectedIndex.value == index
                    ? Colors.green.shade600
                    : Theme.of(Get.context!).colorScheme.secondary,
              ),
            ),
          ],
        )),
      ),
    );
  }
}
