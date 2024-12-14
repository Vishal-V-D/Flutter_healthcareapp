import 'package:flutter/material.dart';

void main() {
  runApp(NotificationApp());
}

class NotificationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medical Notifications',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: NotificationPage(),
    );
  }
}

class NotificationPage extends StatelessWidget {
  final List<Map<String, dynamic>> notifications = [
    {
      'type': 'medication',
      'title': 'Medication Reminder',
      'description': 'Time to take your blood pressure medicine.',
      'timestamp': '2024-12-05 08:00 AM',
      'icon': Icons.medical_services_rounded,
      'details': 'Take 1 tablet of Amlodipine 5mg with water.',
    },
    {
      'type': 'appointment',
      'title': 'Doctor Appointment',
      'description': 'You have an appointment with Dr. Smith.',
      'timestamp': '2024-12-05 02:00 PM',
      'icon': Icons.calendar_today_rounded,
      'details': 'Appointment scheduled at XYZ Clinic, Room 202.',
    },
    {
      'type': 'news',
      'title': 'Latest Health Update',
      'description': 'Breakthrough in cancer research announced.',
      'timestamp': '2024-12-04 06:00 PM',
      'icon': Icons.newspaper_rounded,
      'details': 'A new therapy shows promising results in clinical trials.',
    },
    {
      'type': 'alert',
      'title': 'High Heart Rate Alert',
      'description': 'Your recent heart rate is unusually high.',
      'timestamp': '2024-12-04 01:30 PM',
      'icon': Icons.warning_amber_rounded,
      'details': 'Heart rate recorded at 120 BPM. Please rest and consult a doctor.',
    },
    {
      'type': 'diet',
      'title': 'Healthy Diet Tip',
      'description': 'Include more leafy greens in your meals.',
      'timestamp': '2024-12-03 10:00 AM',
      'icon': Icons.local_dining_rounded,
      'details': 'Spinach, kale, and broccoli are rich in nutrients and good for heart health.',
    },
    {
      'type': 'hydration',
      'title': 'Stay Hydrated',
      'description': 'Reminder to drink water regularly.',
      'timestamp': '2024-12-03 08:00 AM',
      'icon': Icons.water_drop_rounded,
      'details': 'Drink at least 8 glasses of water daily for optimal health.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 10),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: const Color.fromARGB(255, 52, 221, 234).withOpacity(0.1),
                radius: 24,
                child: Icon(
                  notification['icon'],
                  color: Colors.blueAccent,
                  size: 24,
                ),
              ),
              title: Text(
                notification['title'],
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 4),
                  Text(
                    notification['description'],
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    notification['timestamp'],
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotificationDetailPage(
                      title: notification['title'],
                      description: notification['details'],
                      timestamp: notification['timestamp'],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class NotificationDetailPage extends StatelessWidget {
  final String title;
  final String description;
  final String timestamp;

  NotificationDetailPage({
    required this.title,
    required this.description,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal.shade600,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              description,
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            SizedBox(height: 16),
            Text(
              'Received at: $timestamp',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}
