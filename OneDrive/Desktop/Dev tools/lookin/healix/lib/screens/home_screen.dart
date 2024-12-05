import 'package:flutter/material.dart';
import 'package:healix/widgets/service_icon.dart';
import 'package:healix/widgets/appointment_card.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Box
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search medical...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Services
              Text(
                'Services',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              SizedBox(height: 16),
              GridView.count(
                crossAxisCount: 4,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  ServiceIcon(icon: Icons.people, title: "Doctors", color: Colors.blue),
                  ServiceIcon(icon: Icons.local_hospital, title: "Pharmacy", color: Colors.orange),
                  ServiceIcon(icon: Icons.event, title: "Schedule", color: Colors.green),
                  ServiceIcon(icon: Icons.settings, title: "Settings", color: Colors.red),
                ],
              ),
              SizedBox(height: 20),

              // Get Medical Services Box
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.teal.shade300, Colors.teal.shade600],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Get the Best\nmedical Services',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            'We provide quality medical\nservices without further cost.',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.medical_services,
                      color: Colors.white,
                      size: 80,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // Upcoming Appointments Section
              Text(
                'Upcoming Appointments',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              SizedBox(height: 10),
              Container(
                height: 160,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    AppointmentCard(day: "12", weekday: "Tue", doctor: "Dr. Samuel", specialty: "Depression", color: Colors.teal),
                    AppointmentCard(day: "13", weekday: "Wed", doctor: "Dr. Lisa", specialty: "Dermatology", color: Colors.orange),
                    AppointmentCard(day: "14", weekday: "Thu", doctor: "Dr. Mark", specialty: "Pediatrics", color: Colors.purple),
                    AppointmentCard(day: "15", weekday: "Fri", doctor: "Dr. Jane", specialty: "Cardiology", color: Colors.red),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
