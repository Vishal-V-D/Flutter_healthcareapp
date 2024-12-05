import 'package:flutter/material.dart';

class BitcoinScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bitcoin Info'),
      ),
      body: Center(
        child: Text(
          'Welcome to Bitcoin Info Page!',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
