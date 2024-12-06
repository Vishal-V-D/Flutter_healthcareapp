import 'package:flutter/material.dart';

class AppointmentCard extends StatelessWidget {
  final String day;
  final String weekday;
  final String doctor;
  final String specialty;
  final Color color;

  AppointmentCard({required this.day, required this.weekday, required this.doctor, required this.specialty, required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color.withOpacity(0.1),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              day,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(weekday, style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text(doctor, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(specialty, style: TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
