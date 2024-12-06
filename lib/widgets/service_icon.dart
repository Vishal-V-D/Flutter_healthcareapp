import 'package:flutter/material.dart';

class ServiceIcon extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;

  ServiceIcon({required this.icon, required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          padding: EdgeInsets.all(10),
          child: Icon(icon, size: 30, color: color),
        ),
        SizedBox(height: 6),
        Text(
          title,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
