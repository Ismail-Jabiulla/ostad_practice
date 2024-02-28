import 'package:flutter/material.dart';
import 'package:untitled/presentation/app_screen/new_task_screen.dart';
import 'package:untitled/presentation/app_screen/process_screen.dart';
import 'authenication/profile_screen.dart';
import 'canceled_screen.dart';
import 'complete_screen.dart';

class BottomNavigationScreen extends StatefulWidget {
  final VoidCallback toggleTheme;

  const BottomNavigationScreen({Key? key, required this.toggleTheme})
      : super(key: key);

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {

  late List<Widget> _screens;
  int _selectedIndex = 0;
  bool isSelected = false;

  @override
  void initState() {
    super.initState();
    _screens = [
      const NewTaskScreen(),
      const CompeteScreen(),
      const CanceledScreen(),
      const ProcessScreen(),
      ProfileScreen(toggleTheme: widget.toggleTheme),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        height: 70,
        color: Theme.of(context).colorScheme.primary,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ///----New Task-----
            GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = 0;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Icon(Icons.add_task,
                        color:
                            _selectedIndex == 0 ? Colors.green.shade600 : Theme.of(context).colorScheme.secondary),
                    Text(
                      'New Task',
                      style: TextStyle(
                          fontSize: 10,
                          color: _selectedIndex == 0
                              ? Colors.green.shade600
                              : Theme.of(context).colorScheme.secondary),
                    ),
                  ],
                ),
              ),
            ),

            ///----- Complete-----
            GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = 1;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Icon(
                      Icons.done,
                      color: _selectedIndex == 1 ? Colors.green.shade600 : Theme.of(context).colorScheme.secondary,
                    ),
                    Text(
                      'Complete',
                      style: TextStyle(
                        fontSize: 10,
                        color:
                            _selectedIndex == 1 ? Colors.green.shade600 : Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            ///----- Canceled-----
            GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = 2;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Icon(
                      Icons.cancel_outlined,
                      color: _selectedIndex == 2 ? Colors.green.shade600 : Theme.of(context).colorScheme.secondary,
                    ),
                    Text(
                      'Cancelled',
                      style: TextStyle(
                        fontSize: 10,
                        color:
                            _selectedIndex == 2 ? Colors.green.shade600 : Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            ///-----Process----
            GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = 3;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Icon(
                      Icons.incomplete_circle,
                      color: _selectedIndex == 3 ? Colors.green.shade600 : Theme.of(context).colorScheme.secondary,
                    ),
                    Text(
                      'Process',
                      style: TextStyle(
                        fontSize: 10,
                        color:
                            _selectedIndex == 3 ? Colors.green.shade600 : Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            ///-----profile----
            GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = 4;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Icon(
                      Icons.person,
                      color: _selectedIndex == 4 ? Colors.green.shade600 : Theme.of(context).colorScheme.secondary,
                    ),
                    Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: 10,
                        color:
                            _selectedIndex == 4 ? Colors.green.shade600 : Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
