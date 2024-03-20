import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/presentation/app_screen/new_task_screen.dart';
import 'package:untitled/presentation/app_screen/progress_screen.dart';
import '../../data/provider/language_provider.dart';
import 'cancelled_screen.dart';
import 'complete_screen.dart';

class BottomNavigationScreen extends StatefulWidget {

  const BottomNavigationScreen({Key? key})
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
      const CompleteScreen(),
      const CancelledScreen(),
      const ProgressScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {

    var languageProvider = Provider.of<LanguageProvider>(context);
    var currentLanguage = languageProvider.currentLanguage;

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
                      currentLanguage.task,
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
                      currentLanguage.complete,
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
                      currentLanguage.process,
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
                      currentLanguage.cancelled,
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
          ],
        ),
      ),
    );
  }
}
