import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;
  int _selectedIndex = 0;

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Theme Changer',
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Theme Changer'),
        ),
        body: _getBody(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  Widget _getBody(int index) {
    switch (index) {
      case 0:
        return GestureDetector(
          onTap: _toggleTheme,
          child: Container(
            alignment: Alignment.center,
            child: Text(
              'Tap to change theme!',
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        );
      case 1:
        return ProfileScreen(
          toggleTheme: _toggleTheme,
        );
      default:
        return Container();
    }
  }
}

class ProfileScreen extends StatelessWidget {
  final VoidCallback toggleTheme;

  ProfileScreen({required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Profile Page',
            style: TextStyle(fontSize: 20.0),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: toggleTheme,
            child: Text('Toggle Theme'),
          ),
        ],
      ),
    );
  }
}
