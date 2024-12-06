import 'package:flutter/material.dart';

class AIScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AI Screen'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Text(
          'Welcome to the AI Screen!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
