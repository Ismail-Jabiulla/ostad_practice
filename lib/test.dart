import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Update Profile Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UpdateProfileScreen(),
    );
  }
}

class UpdateProfileScreen extends StatefulWidget {
  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  int clickCount = 0;

  void handleClick() {
    setState(() {
      clickCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Profile Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Clicks: $clickCount',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: handleClick,
              child: Text('Update Profile'),
            ),
            SizedBox(height: 20.0),
            if (clickCount > 0)
              Text(
                'You have clicked on the button $clickCount times.',
                style: TextStyle(fontSize: 16.0),
              ),
            if (clickCount > 3)
              const Text(
                'Consider updating your profile!',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
